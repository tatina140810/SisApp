
import UIKit

class EnterСodePasswordViewController: UIViewController {
    
    private let viewModel: EnterCodePasswordViewModel
    
    init(viewModel: EnterCodePasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let keychainService = KeychainService()
    private lazy var textFields: [UITextField] = (1...4).map { _ in createTextField() }
    private let gradientColors: [UIColor] = [UIColor(hex: "#7113E3"), UIColor(hex: "#61C2E2")]
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите код - пароль"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: textFields)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.layer.cornerRadius = 26
        stack.clipsToBounds = true
        stack.backgroundColor = UIColor(hex: "#1C192C")
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        dismissKeyboardGesture()
        view.backgroundColor = .black
        setupNavigationBar()
        setupUI()
       
    }

    
    private func setupNavigationBar() {
        navigationItem.title = "Код приложения"
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont(name: "SFProText-Regular", size: 20) as Any,
            .foregroundColor: UIColor.white
        ]
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(stackView)
       
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 210),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 36),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 52),
            stackView.widthAnchor.constraint(equalToConstant: 200),
            
        ])
    }
    
    private func setupTextFields() {
        textFields.forEach {
            $0.delegate = self
            $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
        textFields.first?.becomeFirstResponder()
    }

    private func createTextField() -> UITextField {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.font = UIFont(name: "SFProDisplay-Bold", size: 25)
        textField.textColor = .white
        textField.keyboardType = .numberPad
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor(hex: "#1C192C")
        textField.attributedPlaceholder = NSAttributedString(
            string: "•",
            attributes: [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.systemFont(ofSize: 50),
                .baselineOffset: 8
            ]
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stackView.layer.cornerRadius = stackView.bounds.height / 2
        applyGradientBorder(to: stackView, colors: gradientColors, borderWidth: 2)
    }
    
    private func applyGradientBorder(to view: UIView, colors: [UIColor], borderWidth: CGFloat) {
        guard view.bounds != .zero else { return }

        let gradientImage = UIImage.gradientImage(bounds: view.bounds, colors: colors)
        let gradientColor = UIColor(patternImage: gradientImage)

        view.layer.borderColor = gradientColor.cgColor
        view.layer.borderWidth = borderWidth
    }

    private func clearTextFields() {
        textFields.forEach { $0.text = "" }
        textFields.first?.becomeFirstResponder()
    }
    
    @objc private func textFieldDidChange() {
        let enteredCode = textFields.map { $0.text ?? "" }.joined()
        viewModel.validateCode(enteredCode)
    }
}


extension EnterСodePasswordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string.count <= 1, CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string)) || string.isEmpty else {
            return false
        }
        
        if let currentIndex = textFields.firstIndex(of: textField) {
            if !string.isEmpty {
                textField.text = string
                if currentIndex < textFields.count - 1 {
                    textFields[currentIndex + 1].becomeFirstResponder()
                } else {
                    textField.resignFirstResponder()
                    textFieldDidChange()
                }
            } else {
                textField.text = ""
                if currentIndex > 0 {
                    textFields[currentIndex - 1].becomeFirstResponder()
                }
            }
        }
        
        return false
    }
}

extension EnterСodePasswordViewController: EnterCodePasswordViewModelDelegate {
    func navigateToAppEntry() {
        guard let navigationController = navigationController else { return }
        let coordinator = EnterCodePasswordCoordinator(navigationController: navigationController)
        coordinator.navigateToAppEntry()
    }
    
    func showInvalidCodeAlert() {
        let alert = UIAlertController(
            title: "Ошибка",
            message: "Введён неверный код",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: { _ in
            self.clearTextFields()
        }))
        present(alert, animated: true)
    }
}
