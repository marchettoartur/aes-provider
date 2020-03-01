
import Foundation
import CryptoSwift

// MARK: - UINT8
// DECRYPT UINT8 PUBLIC METHODS
extension AESProvider {
   
   func decryptData(data: [UInt8]) throws -> [UInt8] {
      
      do {
         let decryptedData = try decrypt(dataToDecrypt: data)
         return decryptedData
      } catch let error { throw error }
   }
   
   func decryptData(data: [UInt8]) throws -> Data {
      
      do {
         let decryptedData = try decrypt(dataToDecrypt: data)
         let decryptedDataConverted = Data(_: decryptedData)
         return decryptedDataConverted
      } catch let error { throw error }
   }
   
   func decryptData(data: [UInt8]) throws -> String {
      
      do {
         let decryptedData = try decrypt(dataToDecrypt: data)
         if let decryptedDataConverted = String(bytes: decryptedData, encoding: .utf8) {
            return decryptedDataConverted
         } else {
            throw AES_ERRORS.couldNotConvertStringToArrayUInt8
         }
      } catch let error { throw error }
   }
}

// MARK: - DATA
// DECRYPT DATA PUBLIC METHODS
extension AESProvider {
   
   func decryptData(data: Data) throws -> [UInt8] {
      
      // Convert data to [UInt8]
      let dataConverted = [UInt8](data)
      
      do {
         let decryptedData = try decrypt(dataToDecrypt: dataConverted)
         return decryptedData
      } catch let error { throw error }
   }
   
   func decryptData(data: Data) throws -> Data {
      
      // Convert data to [UInt8]
      let dataConverted = [UInt8](data)
      
      do {
         let decryptedData = try decrypt(dataToDecrypt: dataConverted)
         let decryptedDataConverted = Data(_: decryptedData)
         return decryptedDataConverted
      } catch let error { throw error }
   }
   
   func decryptData(data: Data) throws -> String {
      
      // Convert data to [UInt8]
      let dataConverted = [UInt8](data)
      
      do {
         let decryptedData = try decrypt(dataToDecrypt: dataConverted)
         if let decryptedDataConverted = String(bytes: decryptedData, encoding: .utf8) {
            return decryptedDataConverted
         } else {
            throw AES_ERRORS.couldNotConvertStringToArrayUInt8
         }
      } catch let error { throw error }
   }
}
