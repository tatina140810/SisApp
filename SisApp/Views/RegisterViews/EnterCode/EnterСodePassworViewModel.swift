import Foundation

protocol EnterCodePasswordViewModelDelegate: AnyObject {
    func navigateToAppEntry()
    func showInvalidCodeAlert()
}

class EnterCodePasswordViewModel {

    private let keychainService: KeychainService
    weak var delegate: EnterCodePasswordViewModelDelegate?
    
    init(keychainService: KeychainService) {
        self.keychainService = keychainService
    }

    func validateCode(_ enteredCode: String) {
        guard enteredCode.count == 4 else { return }
        
        if let savedCode = keychainService.get(forKey: "passwordCode"), enteredCode == savedCode {
            delegate?.navigateToAppEntry()
        } else {
            delegate?.showInvalidCodeAlert()
        }
    }
}
