import Foundation
import UIKit
import Foundation

protocol RegisterVerificationViewModelProtocol {
    var onTimerUpdate: ((String) -> Void)? { get set }
    var onCodeValidationChange: ((Bool) -> Void)? { get set }
    
    func startTimer()
    func validateCode(_ code: String)
    func navigateToAppEntry()
    func didntReceveCode()
}

class RegisterVerificationViewModel: RegisterVerificationViewModelProtocol {
    private var coordinator: RegisterVerificationCoordinatorProtocol
    
    init(coordinator: RegisterVerificationCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    private let model = VerificationModel()
    private var timer: Timer?
    private var remainingTime = 5 * 60
    var onTimerUpdate: ((String) -> Void)?
    var onCodeValidationChange: ((Bool) -> Void)?
    
    func startTimer() {
        updateTimerLabel()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        if remainingTime > 0 {
            remainingTime -= 1
            updateTimerLabel()
        } else {
            timer?.invalidate()
            timer = nil
            onTimerUpdate?("Вы можете запросить новый код.")
        }
    }
    
    private func updateTimerLabel() {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        onTimerUpdate?(String(format: "Запросить код можно\nчерез %02d:%02d", minutes, seconds))
    }
    
    func validateCode(_ code: String) {
        let isValid = code == model.correctCode
        onCodeValidationChange?(isValid)
    }
    
    func navigateToAppEntry() {
        coordinator.navigateToAppEntry()
    }
    
    
    func didntReceveCode() {
        coordinator.navigateToDidNotReceiveCode()
    }
}
