import Foundation
import KeychainSwift

class  PhoneRegisterViewModel {
    private let coordinator: PhoneRegisterCoordinator
    private let keychainService: KeychainService
    
    var subtitle: String = "Введите номер телефона"
    var countryCode: String = "+7"
    
    init(coordinator: PhoneRegisterCoordinator, keychainService: KeychainService) {
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
        
        func backButton() {
            coordinator.backButton()
        }
    }

    
