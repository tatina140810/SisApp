import Foundation
import UIKit
protocol VerificationCoordinatorProtocol: AnyObject {
    func navigateToAppEntry()
    func navigateToDidNotReceiveCode()
    
}
class VerificationCoordinator: VerificationCoordinatorProtocol{
    
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = VerificationViewModel(coordinator: self)
        let verificationVC = VerificationViewController(viewModel: viewModel as VerificationViewModelProtocol)
        navigationController.pushViewController(verificationVC, animated: true)
    }
    
    func navigateToAppEntry() {
        let appEntryCoordinator = AppEntryCoordinator(
            navigationController: navigationController)
        appEntryCoordinator.start()
    }
    
    
    func navigateToDidNotReceiveCode() {
        let didNotReceiveCoordinator = DidntReceiveTheCodeCoordinator(
            navigationController: navigationController)
        didNotReceiveCoordinator.start()
    }
}
