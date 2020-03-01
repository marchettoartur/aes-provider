
import CryptoSwift
import KeychainAccess

/*
 *
 *    AES
 *
 *
 *    REQUIREMENTS:
 *
 *    Key:
 *        - Password
 *        - Salt
 *
 *    Crypter:
 *        - Key
 *        - IV
 *
 *    Encrypt:
 *        - Crypter (Random IV & Key)
 *
 *    Decrypt:
 *        - Crypter (IV in message & Key)
 *
 *
 *    PROCEDURES:
 *
 *    - Encryption:
 *        - Generate random IV
 *        - Get the key or create one
 *        - Create the Crypter with the IV and Key
 *        - Add the IV at the beginning of the message
 *        - Use the Crypter to encrypt the message
 *
 *    - Decryption:
 *        - Read the IV at the beginning of the message
 *        - Get the Key
 *        - Create the Crypter with the IV and Key
 *        - Use the Crypter to decrypt the message
 *
 *    - Create Key
 *        - Get a password
 *        - Hash the password (optional)
 *        - Generate a random Salt
 *        - Create the key with the password and salt
 *        - Save the key in the keychain (optional)
 *
 */

class AESProvider {
   
   // VARIABLES
   internal var keychain   : Keychain
   internal var aesKeyID   : String
   internal var aesKeyName : String
   internal var separatorIV: [UInt8] = []
   
   internal enum AES_ERRORS: Error {
      case cipherKeyNotPresent
      case couldNotFindElementInArray
      case couldNotConvertStringToArrayUInt8
      case noInternetConnection
   }
   
   init(keyName: String) {
      
      self.aesKeyName = keyName
      
      self.aesKeyID = "com.aes." + self.aesKeyName.lowercased()
      
      self.keychain = Keychain(service: aesKeyID)
      
      for _ in 0...978 {
         // 979 times - [0]..[978]
         self.separatorIV.append(169)
      }
   }
}
