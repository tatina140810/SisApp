
import Foundation

protocol DidntReceiveTheCodeViewModelProtocol {
    func didTapChatButton()
}

class DidntReceiveTheCodeViewModel: DidntReceiveTheCodeViewModelProtocol {
    private weak var coordinator: DidntReceiveTheCodeCoordinatorProtocol?
    
    init(coordinator: DidntReceiveTheCodeCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func didTapChatButton() {
        coordinator?.navigateToSupportChat()
    }
    
    
}
