import UIKit

class AppEntryManager {
    private let keychainService: KeychainService
    private let keychainKey = "passwordCode"
    
    init(keychainService: KeychainService) {
        self.keychainService = keychainService
    }
    
    func configureRootViewController(
        for navigationController: UINavigationController
    ) {
        let rootViewController: UIViewController
        
        if isPasswordCodeStoredInKeychain() {
            print("Password code found in Keychain. Initializing CodeMainCoordinator.")
            let codeMainCoordinator = CodeMainCoordinator(
                navigationController: navigationController,
                keychainService: keychainService
            )
            rootViewController = codeMainCoordinator.start()
        } else {
            print("No password code in Keychain. Initializing MainCoordinator.")
            let mainCoordinator = MainCoordinator(
                navigationController: navigationController,
                keychainService: keychainService
            )
            rootViewController = mainCoordinator.start()
        }
        
        navigationController.viewControllers = [rootViewController]
    }
    
    private func isPasswordCodeStoredInKeychain() -> Bool {
        guard let storedValue = keychainService.get(forKey: keychainKey) else {
            return false
        }
        return !storedValue.isEmpty
    }
}
