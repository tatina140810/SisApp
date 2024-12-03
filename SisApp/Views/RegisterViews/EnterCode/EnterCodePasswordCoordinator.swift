import UIKit

class EnterCodePasswordCoordinator {

    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let keychainService = KeychainService()
        let viewModel = EnterCodePasswordViewModel(keychainService: keychainService)
        let viewController = EnterСodePasswordViewController(viewModel: viewModel)
        viewModel.delegate = viewController
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateToAppEntry() {
        let appEntryCoordinator = AppEntryCoordinator(navigationController: navigationController)
        appEntryCoordinator.start()
    }
}
