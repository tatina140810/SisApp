import UIKit
import KeychainSwift

protocol PasswordCodeCreateCoordinatorProtocol {
    func navigateToAppEntry()
    func navigateBack()
}

class PasswordCodeCreateCoordinator: PasswordCodeCreateCoordinatorProtocol {
    private let navigationController: UINavigationController
    private let keychainService: KeychainService

    init(navigationController: UINavigationController, keychainService: KeychainService) {
        self.navigationController = navigationController
        self.keychainService = keychainService
    }

    func navigateToAppEntry() {
        let appEntryVC = AppEntryViewController()
        navigationController.pushViewController(appEntryVC, animated: true)
    }

    func start() {
       
        let viewModel = PasswordCodeCreateViewModel(keychainService: keychainService, coordinator: self)
        let codeCreateVC = PasswordCodeCreateViewController(viewModel: viewModel)
        navigationController.pushViewController(codeCreateVC, animated: true)
    }

    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
}
