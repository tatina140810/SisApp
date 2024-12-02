import UIKit
import KeychainSwift

class PhoneLoginViewController: UIViewController {
    
    private let viewModel: PhoneLoginViewModel
    
    init(viewModel: PhoneLoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "SFProDisplay-Regular", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let codeTextField = GradientTextField(placeholder: "+7")
    private let numberTextField = GradientTextField(placeholder: "9195346703")
    
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "SFProDisplay-Regular", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var getCodeButton: UIButton = {
        let button = ButtonSettings().buttonMaker(
            title: "Получить код",
            target: self,
            action: #selector(getCodeButtonTapped)
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var countryCoodeButton = CountryCodeButton()
    
    let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFProText-Regular", size: 20) as Any,
        .foregroundColor: UIColor.white
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        backButtonSettings()
        navigationItem.title = "Войти"
        navigationController?.navigationBar.titleTextAttributes = attributes
        
        setupBindings()
    }
    
    private func setupUI() {
        view.addSubview(phoneNumberLabel)
        view.addSubview(numberTextField)
        view.addSubview(subTitleLabel)
        view.addSubview(getCodeButton)
        view.addSubview(countryCoodeButton)
      
        NSLayoutConstraint.activate([
            phoneNumberLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 135),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            
            countryCoodeButton.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 15),
            countryCoodeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            countryCoodeButton.widthAnchor.constraint(equalToConstant: 90),
            countryCoodeButton.heightAnchor.constraint(equalToConstant: 50),
            
            numberTextField.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 15),
            numberTextField.leadingAnchor.constraint(equalTo: countryCoodeButton.trailingAnchor, constant: 18),
            numberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            numberTextField.heightAnchor.constraint(equalToConstant: 50),
            
            subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            subTitleLabel.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 22),
            
            getCodeButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 53),
            getCodeButton.heightAnchor.constraint(equalToConstant: 56),
            getCodeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            getCodeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
        ])
    }

    private func backButtonSettings() {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.backward"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupBindings() {
        subTitleLabel.text = viewModel.subtitle
        codeTextField.text = viewModel.countryCode
    }
    
    @objc private func backButtonTapped() {
        viewModel.backButton()
    }
    
    @objc private func getCodeButtonTapped() {
        savePhoneNumber()
        viewModel.getCodeNavigate()
    }
    
    @objc private func savePhoneNumber() {
        guard
            let countryCode = countryCoodeButton.configuration?.title,
            let phoneNumber = numberTextField.text,
            !phoneNumber.isEmpty
        else {
            print("Ошибка: номер телефона не заполнен.")
            return
        }
        
        let fullPhoneNumber = "\(countryCode)\(phoneNumber)"
        viewModel.savePhoneNumber(fullPhoneNumber)
        print("Сохранён номер телефона: \(fullPhoneNumber)")
    }
}
