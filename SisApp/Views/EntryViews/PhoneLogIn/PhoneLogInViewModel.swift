import Foundation
import KeychainSwift

class PhoneLoginViewModel {
    
    private let coordinator: PhoneLoginCoordinator
    private let keychainService: KeychainService
    
    var subtitle: String = "Введите номер телефона"
    var countryCode: String = "+7"
    
    init(coordinator: PhoneLoginCoordinator, keychainService: KeychainService) {
        self.coordinator = coordinator
        self.keychainService = keychainService
    }
    
    func savePhoneNumber(_ fullPhoneNumber: String) {
        let isSaved = keychainService.set(fullPhoneNumber, forKey: "UserPhoneNumber")
        if isSaved {
            print("Phone number saved successfully.")
        } else {
            print("Failed to save phone number.")
        }
    }
    
    
    func getCodeNavigate() {
        coordinator.showVerification()
    }
    
}
