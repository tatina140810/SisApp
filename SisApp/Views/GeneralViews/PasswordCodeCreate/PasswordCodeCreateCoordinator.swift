import UIKit
import KeychainSwift

protocol PasswordCodeCreateCoordinatorProtocol {
    func navigateToAppEntry()
}
class PasswordCodeCreateCoordinator: PasswordCodeCreateCoordinatorProtocol {
    private let navigationController: UINavigationController
    private let keychainService: KeychainService
    
    init(navigationController: UINavigationController, keychainService: KeychainService) {
        self.navigationController = navigationController
        self.keychainService = keychainService
    }
    
    func navigateToAppEntry() {
        let appEntryCoordinator = AppEntryCoordinator(navigationController: navigationController)
        appEntryCoordinator.start()
    }
    
    func start() {
        
        let viewModel = PasswordCodeCreateViewModel(keychainService: keychainService, coordinator: self)
        let codeCreateVC = PasswordCodeCreateViewController(viewModel: viewModel)
        navigationController.pushViewController(codeCreateVC, animated: true)
    }
    
}
