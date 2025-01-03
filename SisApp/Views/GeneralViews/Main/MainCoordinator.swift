import UIKit

protocol MainCoordinatorProtocol {
    func showPhoneLogin()
    func showPhoneRegister()
}

class MainCoordinator: MainCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    private let keychainService: KeychainService
    
    init(navigationController: UINavigationController, keychainService: KeychainService) {
        self.navigationController = navigationController
        self.keychainService = keychainService
    }
    
    
    func start() -> UIViewController {
        let viewModel = MainViewModel(keychainService: keychainService, coordinator: self)
        let viewController = MainViewController(viewModel: viewModel)
        return viewController
    }
    
    
    func showPhoneLogin() {
        let phoneLoginCoordinator = PhoneLoginCoordinator(
            navigationController: navigationController,
            keychainService: keychainService
        )
        phoneLoginCoordinator.start()
    }
    
    func showPhoneRegister() {
        let phoneRegisterCoordinator = PhoneRegisterCoordinator(
            navigationController: navigationController,
            keychainService: keychainService
        )
        phoneRegisterCoordinator.start()
    }
}
