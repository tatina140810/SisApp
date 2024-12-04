import UIKit

class PasswordCodeCreateViewController: UIViewController {
    
    private var viewModel: PasswordCodeCreateViewModelProtocol
    
    private let gradientColors: [UIColor] = [UIColor(hex: "#7113E3"), UIColor(hex: "#61C2E2")]
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
        stack.layer.cornerRadius = 26
        stack.clipsToBounds = true
        stack.backgroundColor = UIColor(hex: "#1C192C")
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
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            
            
        ])
    }
    
    private func setupTextFields() {
        textFields.forEach { $0.delegate = self }
        firstTextField.becomeFirstResponder()
    }
    
    private func createTextField() -> UITextField {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.font = UIFont(name: "SFProDisplay-Bold", size: 25)
        textField.textColor = .white
        textField.keyboardType = .numberPad
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor(hex: "#1C192C")
        let placeholderText = "·"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 100),
            .baselineOffset: 12
        ]
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
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
   
    private func setupBindings() {
        viewModel.onCodeSaved = {
            self.viewModel.navigateToApp()
        }
    }
    
    @objc func skipButtonTapped(){
        let appEntryCoordinator = AppEntryCoordinator(navigationController: navigationController!)
        appEntryCoordinator.start()
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
