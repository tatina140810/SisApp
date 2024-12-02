import Foundation
import UIKit
protocol VerificationCoordinatorProtocol{
    func navigateToAppEntry()
    func navigateToDidNotReceiveCode()
    func backButton()
    
}
class VerificationCoordinator: VerificationCoordinatorProtocol {
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
        let appEntryVC = AppEntryViewController()
        navigationController.pushViewController(appEntryVC, animated: true)
    }
    
    func navigateToDidNotReceiveCode() {
        let didNotReceiveVC = DidntReceveTheCodeViewController()
        navigationController.pushViewController(didNotReceiveVC, animated: true)
    }
    func backButton(){
        navigationController.popViewController(animated: true)
    }
}
