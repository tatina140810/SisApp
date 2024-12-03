import UIKit

protocol DidntReceiveTheCodeCoordinatorProtocol: AnyObject {
    func navigateToSupportChat()
}
class DidntReceiveTheCodeCoordinator: DidntReceiveTheCodeCoordinatorProtocol {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = DidntReceiveTheCodeViewModel(coordinator: self)
        let viewController = DidntReceveTheCodeViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateToSupportChat() {
        print("Navigate to Support Chat") 
    }
    
}
