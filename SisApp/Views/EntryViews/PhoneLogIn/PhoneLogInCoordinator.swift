import UIKit
import KeychainSwift

class PhoneLoginCoordinator {
    
    private let navigationController: UINavigationController
    private let keychainService: KeychainService
    
    
    init(navigationController: UINavigationController, keychainService: KeychainService) {
        self.navigationController = navigationController
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
    
    func start() {
        let viewModel = PhoneLoginViewModel(coordinator: self, keychainService: keychainService)
        let phoneLoginVC = PhoneLoginViewController(viewModel: viewModel)
        navigationController.pushViewController(phoneLoginVC, animated: true)
    }
    func showVerification() {
        let verificationCoordinator = VerificationCoordinator (
            navigationController: navigationController)
        verificationCoordinator.start()
    }
    
}
