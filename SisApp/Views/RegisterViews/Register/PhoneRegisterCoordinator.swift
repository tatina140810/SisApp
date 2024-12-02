import UIKit

class PhoneRegisterCoordinator {
    
    private let navigationController: UINavigationController
    private let keychainService: KeychainService


    init(navigationController: UINavigationController, keychainService: KeychainService) {
        self.navigationController = navigationController
        self.keychainService = keychainService
    }

    func didEnterPhoneNumber(_ fullPhoneNumber: String) {
        let isSaved = keychainService.set(fullPhoneNumber, forKey: "UserPhoneNumber")
        if isSaved {
            print("Phone number saved successfully.")
        } else {
            print("Failed to save phone number.")
        }
    }


    func start() {
        let viewModel = PhoneRegisterViewModel(coordinator: self, keychainService: keychainService)
        let phoneRegisterVC = PhoneRegisterViewController(viewModel: viewModel)
        navigationController.pushViewController(phoneRegisterVC , animated: true)
    }
    func showVerification() {
            let verificationCoordinator = RegisterVerificationCoordinator (
                navigationController: navigationController, keychainService: keychainService)
        verificationCoordinator.start()
        }


    func backButton() {
        navigationController.popViewController(animated: true)
    }
}

