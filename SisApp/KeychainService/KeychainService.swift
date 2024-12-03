import Foundation
import Security

class KeychainService {
    
    func set(_ value: String, forKey key: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        
        SecItemDelete(query as CFDictionary)
        
        
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    func get(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    func clear() {
        let secItemClasses = [
            kSecClassGenericPassword,
            kSecClassInternetPassword,
            kSecClassCertificate,
            kSecClassKey,
            kSecClassIdentity
        ]
        
        for itemClass in secItemClasses {
            let query: [String: Any] = [kSecClass as String: itemClass]
            let status = SecItemDelete(query as CFDictionary)
            
            if status == errSecSuccess {
                print("Successfully deleted keychain items of type: \(itemClass)")
            } else if status == errSecItemNotFound {
                print("No items of type \(itemClass) found in Keychain.")
            } else {
                print("Failed to delete items of type \(itemClass), status: \(status)")
            }
        }
    }
}
