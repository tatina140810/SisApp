import UIKit

class PhoneLoginViewController: UIViewController {
    
    private var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Номер телефона"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "SFProDisplay-Regular", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var codeTextField = TextFieldSettings().textFieldMaker(placeholder: "+7")
    private var numberTextField = TextFieldSettings().textFieldMaker(placeholder: "9195346703")
    
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Код придет на ваш номер телефона"
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
            action: #selector(entryButtonTapped)
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
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
        
    }
    private func setupUI(){
        
        view.addSubview(phoneNumberLabel)
        view.addSubview(codeTextField)
        view.addSubview(numberTextField)
        view.addSubview(subTitleLabel)
        view.addSubview(getCodeButton)
        
        
        NSLayoutConstraint.activate([
            
            phoneNumberLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 135),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            
            codeTextField.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 15),
            codeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            codeTextField.widthAnchor.constraint(equalToConstant: 70),
            codeTextField.heightAnchor.constraint(equalToConstant: 50),
            
            
            numberTextField.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 15),
            numberTextField.leadingAnchor.constraint(equalTo: codeTextField.trailingAnchor, constant: 18),
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
    private func backButtonSettings(){
        let backButton = UIBarButtonItem(
              image: UIImage(systemName: "arrow.backward"),
              style: .plain,
              target: self,
              action: #selector(backButtonTapped)
          )
          backButton.tintColor = .white
          navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func entryButtonTapped(){
        let vc = VerificationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

