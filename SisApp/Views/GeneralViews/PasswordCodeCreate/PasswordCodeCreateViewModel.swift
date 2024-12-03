import Foundation
import KeychainSwift

protocol PasswordCodeCreateViewModelProtocol {
    var onCodeSaved: (() -> Void)? { get set }
    func saveCode(_ code: String)
    func navigateToApp()
}

class PasswordCodeCreateViewModel: PasswordCodeCreateViewModelProtocol {
    private let keychainService: KeychainService
    private var coordinator: PasswordCodeCreateCoordinatorProtocol?
    
    var onCodeSaved: (() -> Void)?
    
    
    init(keychainService: KeychainService, coordinator: PasswordCodeCreateCoordinatorProtocol) {
        self.keychainService = keychainService
        self.coordinator = coordinator
    }
    
    func saveCode(_ code: String) {
        if keychainService.set(code, forKey: "passwordCode") {
            print("Code successfully saved to Keychain: \(code)")
            onCodeSaved?()
        } else {
            print("Failed to save code to Keychain.")
        }
    }
    func navigateToApp(){
        coordinator!.navigateToAppEntry()
    }
    
}
