//import UIKit
//import KeychainSwift
//
//class PasswordCodeCreatedViewController: UIViewController {
//    
//    private let keychainService = KeychainSwift()
//    
//    private var codeCreateLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Создайте код приложения"
//        label.textColor = .white
//        label.textAlignment = .center
//        label.font = UIFont(name: "SFProText-Bold", size: 24)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private var subTitleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Введите код из символов"
//        label.textColor = UIColor(hex: "#999999")
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private lazy var firstTextField: UITextField = createTextField()
//    private lazy var secondTextField: UITextField = createTextField()
//    private lazy var thirdTextField: UITextField = createTextField()
//    private lazy var forthTextField: UITextField = createTextField()
//    
//    private lazy var textFields: [UITextField] = [firstTextField, secondTextField, thirdTextField, forthTextField]
//    
//    private lazy var stackView: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: textFields)
//        stack.axis = .horizontal
//        stack.distribution = .fillEqually
//        stack.spacing = 10
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        return stack
//    }()
//    
//    private lazy var skipButton: UIButton = {
//        let button = ButtonSettings().buttonMaker(
//            title: "Пропустить",
//            target: self,
//            action: #selector(skipButtonTapped)
//        )
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    let attributes: [NSAttributedString.Key: Any] = [
//        .font: UIFont(name: "SFProText-Regular", size: 20) as Any,
//        .foregroundColor: UIColor.white
//    ]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .black
//        setupUI()
//        setupTextFields()
//        backButtonSettings()
//        navigationItem.title = "Код приложения"
//        navigationController?.navigationBar.titleTextAttributes = attributes
//    }
//    
//    private func setupUI() {
//        view.addSubview(codeCreateLabel)
//        view.addSubview(subTitleLabel)
//        view.addSubview(stackView)
//        view.addSubview(skipButton)
//        
//        NSLayoutConstraint.activate([
//            codeCreateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 168),
//            codeCreateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            subTitleLabel.topAnchor.constraint(equalTo: codeCreateLabel.bottomAnchor, constant: 47),
//            subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            stackView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 36),
//            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            stackView.heightAnchor.constraint(equalToConstant: 52),
//            stackView.widthAnchor.constraint(equalToConstant: 200),
//            
//            skipButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 28),
//            skipButton.heightAnchor.constraint(equalToConstant: 56),
//            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
//            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35)
//        ])
//    }
//    
//
//    
//    private func setupTextFields() {
//        textFields.forEach { textField in
//            textField.delegate = self
//        }
//        firstTextField.becomeFirstResponder()
//    }
//    
//    private func backButtonSettings() {
//        let backButton = UIBarButtonItem(
//            image: UIImage(systemName: "arrow.backward"),
//            style: .plain,
//            target: self,
//            action: #selector(backButtonTapped)
//        )
//        backButton.tintColor = .white
//        navigationItem.leftBarButtonItem = backButton
//    }
//    
//    @objc func skipButtonTapped() {
//        navigateToAppEntry()
//    }
//    
//    @objc func backButtonTapped() {
//        navigationController?.popViewController(animated: true)
//    }
//    
//    private func saveCodeToKeychain() {
//        let code = textFields.compactMap { $0.text }.joined()
//        if code.count == 4 {
//            if keychainService.set(code, forKey: "passwordCode") {
//                print("Code successfully saved to Keychain: \(code)")
//                navigateToAppEntry()
//            } else {
//                print("Failed to save code to Keychain.")
//            }
//        }
//    }
//    
//    private func navigateToAppEntry() {
//        let vc = AppEntryViewController()
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}
//
//extension PasswordCodeCreatedViewController: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard string.count <= 1, CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string)) || string.isEmpty else {
//            return false
//        }
//        
//        if let currentIndex = textFields.firstIndex(of: textField) {
//            if !string.isEmpty { // Ввод цифры
//                textField.text = string
//                if currentIndex < textFields.count - 1 {
//                    textFields[currentIndex + 1].becomeFirstResponder()
//                } else {
//                    textField.resignFirstResponder()
//                    saveCodeToKeychain()
//                }
//            } else { // Удаление цифры
//                textField.text = ""
//                if currentIndex > 0 {
//                    textFields[currentIndex - 1].becomeFirstResponder()
//                }
//            }
//        }
//        return false
//    }
//}
import UIKit

class PasswordCodeCreateViewController: UIViewController {
    
    private var viewModel: PasswordCodeCreateViewModelProtocol


    private lazy var firstTextField: UITextField = createTextField()
    private lazy var secondTextField: UITextField = createTextField()
    private lazy var thirdTextField: UITextField = createTextField()
    private lazy var forthTextField: UITextField = createTextField()

    private lazy var textFields: [UITextField] = [firstTextField, secondTextField, thirdTextField, forthTextField]
    private var codeCreateLabel: UILabel = {
           let label = UILabel()
           label.text = "Создайте код приложения"
           label.textColor = .white
           label.textAlignment = .center
           label.font = UIFont(name: "SFProText-Bold", size: 24)
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
   
       private var subTitleLabel: UILabel = {
           let label = UILabel()
           label.text = "Введите код из символов"
           label.textColor = UIColor(hex: "#999999")
           label.textAlignment = .center
           label.numberOfLines = 0
           label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
   
       private lazy var skipButton: UIButton = {
           let button = ButtonSettings().buttonMaker(
               title: "Пропустить",
               target: self,
               action: #selector(skipButtonTapped)
           )
           button.translatesAutoresizingMaskIntoConstraints = false
           return button
       }()
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: textFields)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    init(viewModel: PasswordCodeCreateViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        setupBindings()
        setupTextFields()
        setupNavigation()
    }

    private func setupUI() {
        
            view.addSubview(codeCreateLabel)
            view.addSubview(subTitleLabel)
            view.addSubview(stackView)
            view.addSubview(skipButton)
    
            NSLayoutConstraint.activate([
                codeCreateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 168),
                codeCreateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    
                subTitleLabel.topAnchor.constraint(equalTo: codeCreateLabel.bottomAnchor, constant: 47),
                subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    
                stackView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 36),
                stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stackView.heightAnchor.constraint(equalToConstant: 52),
                stackView.widthAnchor.constraint(equalToConstant: 200),
    
                skipButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 28),
                skipButton.heightAnchor.constraint(equalToConstant: 56),
                skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
                skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35)
            ])
        }

    private func setupTextFields() {
        textFields.forEach { $0.delegate = self }
        firstTextField.becomeFirstResponder()
    }

    private func setupNavigation() {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.backward"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
    }
    private func createTextField() -> UITextField {
            let textField = UITextField()
            textField.textAlignment = .center
            textField.font = UIFont(name: "SFProDisplay-Bold", size: 25)
            textField.textColor = .white
            textField.keyboardType = .numberPad
            let placeholderText = "•"
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.systemFont(ofSize: 50)
            ]
            textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }

    private func setupBindings() {
        viewModel.onCodeSaved = {
            self.viewModel.navigateToApp()
        }
    }


    @objc private func backButtonTapped() {
        viewModel.backButton()
    }
    @objc func skipButtonTapped(){
        let vc = AppEntryViewController()
               navigationController?.pushViewController(vc, animated: true)
    }

    private func saveCode() {
        let code = textFields.compactMap { $0.text }.joined()
        if code.count == 4 {
            viewModel.saveCode(code)
        }
    }
}

extension PasswordCodeCreateViewController: UITextFieldDelegate {
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
                    saveCode()
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
