
import Foundation

protocol CodeMainViewModelProtocol {
    func didTapEntryButton()
    func didTapRegisterButton()
}

class CodeMainViewModel: CodeMainViewModelProtocol {
    private let keychainService: KeychainService
    private let coordinator: CodeMainCoordinatorProtocol
    
    init(keychainService: KeychainService, coordinator: CodeMainCoordinatorProtocol) {
        self.keychainService = keychainService
        self.coordinator = coordinator
    }
    
    func didTapEntryButton() {
        coordinator.navigateToEnterCodePassword()
    }
    
    func didTapRegisterButton() {
        coordinator.navigateToPhoneRegister()
    }
}
