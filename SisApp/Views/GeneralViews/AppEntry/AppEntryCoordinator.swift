import UIKit

protocol AppEntryCoordinatorProtocol: AnyObject {
    func navigateToAppEntry()
}

class AppEntryCoordinator: AppEntryCoordinatorProtocol {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let viewModel = AppEntryViewModel(coordinator: self)
        let appEntryVC = AppEntryViewController(viewModel: viewModel as AppEntryViewModelProtocol)
        navigationController.pushViewController(appEntryVC, animated: true)
    }
    
    func navigateToAppEntry() {
        print("Navigate to the app entry point")
        
    }
}
