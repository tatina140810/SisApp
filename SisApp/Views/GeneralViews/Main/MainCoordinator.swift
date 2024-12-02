import UIKit

protocol MainCoordinatorProtocol{
    func showPhoneLogin()
    func showPhoneRegister()
    
}
class MainCoordinator: MainCoordinatorProtocol {
    private let keychainService: KeychainService

    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, keychainService: KeychainService){
        self.navigationController = navigationController
        self.keychainService = keychainService
    }
    func start(){
        let viewModel = MainViewModel(coordinator: self)
        let viewController = MainViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showPhoneLogin() {
            let phoneLoginCoordinator = PhoneLoginCoordinator(
                navigationController: navigationController,
                keychainService: keychainService 
            )
            phoneLoginCoordinator.start()
        }
    func showPhoneRegister() {
        let keychainService = KeychainService()
        let phoneRegisterCoordinator = PhoneRegisterCoordinator (
            navigationController: navigationController, keychainService: keychainService)
        phoneRegisterCoordinator.start()
    }
    
    
}
