//
//  RegisterVerificationCoordinatorProtocol.swift
//  SisApp
//
//  Created by Tatina Dzhakypbekova on 2/12/24.
//

import Foundation
import UIKit
protocol RegisterVerificationCoordinatorProtocol{
    func navigateToAppEntry()
    func navigateToDidNotReceiveCode()
    
}
class RegisterVerificationCoordinator: RegisterVerificationCoordinatorProtocol {
    private let navigationController: UINavigationController
    private let keychainService: KeychainService
    
    
    init(navigationController: UINavigationController, keychainService: KeychainService) {
        self.navigationController = navigationController
        self.keychainService = keychainService
    }
    
    func start() {
        let viewModel = RegisterVerificationViewModel(coordinator: self)
        let verificationVC = RegisterVerificationViewController(viewModel: viewModel as RegisterVerificationViewModelProtocol)
        navigationController.pushViewController(verificationVC, animated: true)
    }
    
    func navigateToAppEntry() { 
        let passwordCodeCreateVC = PasswordCodeCreateCoordinator(navigationController: navigationController, keychainService: keychainService)
        passwordCodeCreateVC.start()
    }
    
    func navigateToDidNotReceiveCode() {
        let didNotReceiveCoordinator = DidntReceiveTheCodeCoordinator(navigationController: navigationController)
        didNotReceiveCoordinator.start()
    }
}
