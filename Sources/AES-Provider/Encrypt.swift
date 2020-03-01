
import Foundation
import CryptoSwift

// MARK: - UINT8
// ENCRYPT UINT8 PUBLIC METHODS
extension AESProvider {
   
   func encryptData(data: [UInt8]) throws -> [UInt8] {
      
      do {
         let encryptedData = try encrypt(dataToEncrypt: data)
         return encryptedData
      } catch let error { throw error }
   }
   
   func encryptData(data: [UInt8]) throws -> Data {
      
      do {
         let encryptedData = try encrypt(dataToEncrypt: data)
         let encryptedDataConverted = Data(_: encryptedData)
         return encryptedDataConverted
      } catch let error { throw error }
   }
}

// MARK: - STRING
// ENCRYPT STRING PUBLIC METHODS
extension AESProvider {
   
   func encryptData(data: String) throws -> [UInt8] {
      
      // Convert data to [UInt8]
      let dataConverted: [UInt8] = Array(data.utf8)
      
      do {
         let encryptedData = try encrypt(dataToEncrypt: dataConverted)
         return encryptedData
      } catch let error { throw error }
   }
   
   func encryptData(data: String) throws -> Data {
      
      // Convert data to [UInt8]
      let dataConverted: [UInt8] = Array(data.utf8)
      
      do {
         let encryptedData = try encrypt(dataToEncrypt: dataConverted)
         let encryptedDataConverted = Data(_: encryptedData)
         return encryptedDataConverted
      } catch let error { throw error }
   }
}

// MARK: - DATA
// ENCRYPT DATA PUBLIC METHODS
extension AESProvider {
   
   func encryptData(data: Data) throws -> [UInt8] {
      
      // Convert data to [UInt8]
      let dataConverted = [UInt8](data)
      
      do {
         let encryptedData = try encrypt(dataToEncrypt: dataConverted)
         return encryptedData
      } catch let error { throw error }
   }
   
   func encryptData(data: Data) throws -> Data {
      
      // Convert data to [UInt8]
      let dataConverted = [UInt8](data)
      
      do {
         let encryptedData = try encrypt(dataToEncrypt: dataConverted)
         let encryptedDataConverted = Data(_: encryptedData)
         return encryptedDataConverted
      } catch let error { throw error }
   }
}

// MARK: - CHARACTER
// ENCRYPT CHARACTER PUBLIC METHODS
extension AESProvider {
   
   func encryptData(data: [Character]) throws -> [UInt8] {
      
      // Convert data to [UInt8]
      let charArray: [Character] = data
      let dataConverted = String(charArray).utf8.map {
         UInt8($0)
      }
      
      do {
         let encryptedData = try encrypt(dataToEncrypt: dataConverted)
         return encryptedData
      } catch let error { throw error }
   }
   
   func encryptData(data: [Character]) throws -> Data {
      
      // Convert data to [UInt8]
      let charArray: [Character] = data
      let dataConverted = String(charArray).utf8.map {
         UInt8($0)
      }
      
      do {
         let encryptedData = try encrypt(dataToEncrypt: dataConverted)
         let encryptedDataConverted = Data(_: encryptedData)
         return encryptedDataConverted
      } catch let error { throw error }
   }
}
