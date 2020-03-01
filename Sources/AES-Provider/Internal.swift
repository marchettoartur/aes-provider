
import Foundation
import CryptoSwift

// MARK: - ENCRYPT / DECRYPT PRIVATE METHODS
extension AESProvider {
   
   internal func encrypt(dataToEncrypt: [UInt8]) throws -> [UInt8] {
      
      // Varibles
      var cipherKey       : Data?
      var encryptedData : [UInt8]
      var cipherKeyArray: [UInt8]
      
      // 1) Generate IV
      let cipherIV: [UInt8] = generateIV()
      
      // 2) Read Key
      do {
         cipherKey = try keychain.getData(aesKeyName)
      } catch let error { throw error }
      
      // Generate the key
      if cipherKey == nil {
         // 3) Generate the key ([UInt8])
         // Key not found, create one
         do {
            cipherKeyArray = try generateKey()
         } catch let error { throw error }
      } else {
         // Key found
         // 3) Convert the read key from Data to [UInt8]
         cipherKeyArray = cipherKey!.bytes
      }
      
      // 4) Encrypt the message
      do {
         encryptedData = try AES(
            key: cipherKeyArray,
            blockMode: CBC(iv: cipherIV),
            padding: .pkcs7
         )
         .encrypt(dataToEncrypt)
      } catch let error { throw error }
      
      // 5) Return data
      return cipherIV + separatorIV + encryptedData
   }
   
   internal func decrypt(dataToDecrypt: [UInt8]) throws -> [UInt8] {
      
      // Variables
      let cipherKey       : Data?
      let cipherKeyArray: [UInt8]
      let dataSplit       : (iv: [UInt8], message: [UInt8])
      
      // 1) Split data into the IV and the message to decrypt
      do {
         dataSplit = try splitArray(data: dataToDecrypt)
      } catch let error { throw error }
      
      // 2) Read the key
      do {
         cipherKey = try keychain.getData(aesKeyName)
      } catch let error { throw error }
      
      // 3) Convert the read key from Data to [UInt8]
      if cipherKey != nil {
         cipherKeyArray = cipherKey!.bytes
      } else { throw AES_ERRORS.cipherKeyNotPresent }
      
      // 4) Decrypt the message
      do {
         let decryptedData = try AES(
            key: cipherKeyArray,
            blockMode: CBC(iv: dataSplit.iv),
            padding: .pkcs7
         )
         .decrypt(dataSplit.message)
         // 5) Return the message
         return decryptedData
      } catch let error { throw error }
   }
}

// MARK: - GENERATE PRIVATE METHODS
extension AESProvider {
   
   internal func generateIV() -> [UInt8] {
      let iv: [UInt8] = AES.randomIV(AES.blockSize)
      return iv
   }
   
   internal func generateKey() throws -> [UInt8] {
      
      var cipherKey: [UInt8] = []
      
      for _ in 0...31 {
         cipherKey.append(UInt8(Int.random(in: 0...254)))
      }
      
      do {
         try saveToKeychain(key: cipherKey)
      } catch let error { throw error }
      
      return cipherKey
   }
}

// MARK: - OTHER PRIVATE METHODS
extension AESProvider {
   
   internal func saveToKeychain(key: [UInt8]) throws {
      
      let keyConverted = Data(key)
      
      do {
         try keychain
            .synchronizable(true)
            .set(keyConverted, key: aesKeyName)
      } catch let error { throw error }
   }
   
   internal func splitArray(data: [UInt8]) throws -> ([UInt8], [UInt8]) {
      
      let tuple: (posBeforeElement: Int?, posAfterElement: Int?) = findRepeatingItemInArray(data: data, referenceArray: separatorIV)
      
      if tuple.posBeforeElement != nil, tuple.posAfterElement != nil {
         // Element found
         var firstPart : [UInt8] = []
         var secondPart: [UInt8] = []
         
         for index in 0...tuple.posBeforeElement! {
            firstPart.append(data[index])
         }
         
         for index in tuple.posAfterElement!..<data.count {
            secondPart.append(data[index])
         }
         
         return (firstPart, secondPart)
      } else { throw AES_ERRORS.couldNotFindElementInArray }
   }
   
   internal func findRepeatingItemInArray(
      data: [UInt8],
      elementToFind: UInt8,
      repetitions: Int
   ) -> (posBeforeElement: Int?, posAfterElement: Int?
      ) {
      var counter      : Int = 0
      var position     : Int = 0
      var lastPosition: Int = 0
      
      for index in 0...data.count {
         if data[index] == elementToFind {
            if counter == 0 {
               position  = index
               position -= 1
            }
            counter += 1
         } else {
            counter  = 0
            position = 0
         }
         
         if counter == repetitions {
            lastPosition  = index
            lastPosition += 1
            return (position, lastPosition)
         }
      }
      
      return (nil, nil)
   }
   
   internal func findRepeatingItemInArray(
      data: [UInt8],
      referenceArray: [UInt8]
   ) -> (posBeforeElement: Int?, posAfterElement: Int?
      ) {
      var counter      : Int = 0
      var position     : Int = 0
      var lastPosition: Int = 0
      
      for index in 0...data.count {
         if data[index] == referenceArray[0] {
            if counter == 0 {
               position  = index
               position -= 1
            }
            counter += 1
         } else {
            counter  = 0
            position = 0
         }
         
         if counter == referenceArray.count {
            lastPosition  = index
            lastPosition += 1
            return (position, lastPosition)
         }
      }
      
      return (nil, nil)
   }
}
