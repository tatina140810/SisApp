import Foundation

protocol AppEntryViewModelProtocol {
    func didTapAppEntryButton()
}
class AppEntryViewModel: AppEntryViewModelProtocol {
    private weak var coordinator: AppEntryCoordinatorProtocol?
    
    init(coordinator: AppEntryCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func didTapAppEntryButton() {
        coordinator?.navigateToAppEntry()
    }
    
}
