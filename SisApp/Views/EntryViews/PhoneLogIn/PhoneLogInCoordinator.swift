import UIKit
import KeychainSwift

class PhoneLoginCoordinator {
    private let navigationController: UINavigationController
    private let keychainService: KeychainService


    init(navigationController: UINavigationController, keychainService: KeychainService) {
        self.navigationController = navigationController
        self.keychainService = keychainService
    }

    func didEnterPhoneNumber(_ fullPhoneNumber: String) {
        keychainService.save(fullPhoneNumber: fullPhoneNumber)
    }

    func start() {
        let viewModel = PhoneLoginViewModel(coordinator: self, keychainService: keychainService)
        let phoneLoginVC = PhoneLoginViewController(viewModel: viewModel)
        navigationController.pushViewController(phoneLoginVC, animated: true)
    }

    func navigateToVerification() {
        let verificationVC = VerificationViewController()
        navigationController.pushViewController(verificationVC, animated: true)
    }

    func backButton() {
        navigationController.popViewController(animated: true)
    }
}
