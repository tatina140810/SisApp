import Security
import Foundation

//class KeychainService {
//    
//    func save(fullPhoneNumber: String) {
//        guard let data = fullPhoneNumber.data(using: .utf8) else { return }
//
//        let query: [String: Any] = [
//            kSecClass as String: kSecClassGenericPassword,
//            kSecAttrAccount as String: "userPhoneNumber",
//            kSecValueData as String: data
//        ]
//
//        SecItemDelete(query as CFDictionary)
//
//        let status = SecItemAdd(query as CFDictionary, nil)
//        if status != errSecSuccess {
//            print("Не удалось сохранить номер телефона в Keychain: \(status)")
//        }
//    }
//
//    func fetchPhoneNumber() -> String? {
//        let query: [String: Any] = [
//            kSecClass as String: kSecClassGenericPassword,
//            kSecAttrAccount as String: "userPhoneNumber",
//            kSecReturnData as String: true,
//            kSecMatchLimit as String: kSecMatchLimitOne
//        ]
//
//        var item: CFTypeRef?
//        let status = SecItemCopyMatching(query as CFDictionary, &item)
//        guard status == errSecSuccess, let data = item as? Data else {
//            print("Не удалось получить номер телефона из Keychain: \(status)")
//            return nil
//        }
//
//        return String(data: data, encoding: .utf8)
//    }
//}
import KeychainSwift

class KeychainService {
    private let keychain = KeychainSwift()

    func save(fullPhoneNumber: String) {
        keychain.set(fullPhoneNumber, forKey: "userPhoneNumber")
    }

    func getPhoneNumber() -> String? {
        return keychain.get("userPhoneNumber")
    }

    func deletePhoneNumber() {
        keychain.delete("userPhoneNumber")
    }
}
