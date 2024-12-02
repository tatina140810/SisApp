import Foundation

protocol MainViewModelProtocol {
    var title: String { get }
    var subTitle: String { get }
    var noAccountText: String { get }
    func handleEntryButtonTapped()
    func handleNoAccauntTapped()
}
class MainViewModel: MainViewModelProtocol {
    
    private let coordinator: MainCoordinatorProtocol
    
    init(coordinator: MainCoordinatorProtocol){
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
