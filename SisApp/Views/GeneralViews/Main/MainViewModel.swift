import Foundation

protocol MainViewModelProtocol {
    var title: String { get }
    var subTitle: String { get }
    var noAccountText: String { get }
    func handleEntryButtonTapped()
    func handleNoAccauntTapped()
}
class MainViewModel: MainViewModelProtocol {
    
    private let keychainService: KeychainService
    private let coordinator: MainCoordinatorProtocol
    
    init(keychainService: KeychainService, coordinator: MainCoordinatorProtocol) {
        self.keychainService = keychainService
        self.coordinator = coordinator
    }
    
    var title: String{
        return "SIS"
    }
    
    var subTitle: String {
        return "Выбери свою безопасность"
    }
    
    var noAccountText: String {
        return "У вас нет аккаунта?\nЗарегистрируйтесь сейчас"
        
    }
    
    func handleEntryButtonTapped() {
        coordinator.showPhoneLogin()
    }
    
    func handleNoAccauntTapped() {
        coordinator.showPhoneRegister()
    }
    
    
}
