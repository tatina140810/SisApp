import UIKit

protocol CodeMainCoordinatorProtocol: AnyObject {
    func navigateToEnterCodePassword()
    func navigateToPhoneRegister()
}

class CodeMainCoordinator: CodeMainCoordinatorProtocol {
    
    
    private let navigationController: UINavigationController
    private let keychainService: KeychainService
    
    init(navigationController: UINavigationController, keychainService: KeychainService) {
        self.navigationController = navigationController
        self.keychainService = keychainService
    }
    func start() -> UIViewController {
        let viewModel = CodeMainViewModel(
            keychainService: keychainService,
            coordinator: self
        )
        let viewController = CodeMainViewController(viewModel: viewModel)
        return viewController
    }
    
    
    func navigateToEnterCodePassword() {
        let enterCodeVC = EnterCodePasswordCoordinator(navigationController: navigationController)
        enterCodeVC.start()
    }
    
    func navigateToPhoneRegister() {
        let phoneRegisterCoordinator = PhoneRegisterCoordinator(
            navigationController: navigationController,
            keychainService: keychainService
        )
        phoneRegisterCoordinator.start()
    }
}

