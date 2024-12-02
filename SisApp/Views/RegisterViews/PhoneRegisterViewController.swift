
import UIKit

class PhoneRegisterViewController: UIViewController {
    
    private var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Номер телефона"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "SFProDisplay-Regular", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var codeTextField = GradientTextField(placeholder: "+7")
    private var numberTextField = GradientTextField(placeholder: "9195346703")
   
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
        countryCodeButtonSetup()
        backButtonSettings()
        navigationItem.title = "Зарегистрироваться"
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
    func countryCodeButtonSetup(){
        let countryCodeButton = UIButton(type: .custom)
        countryCodeButton.setImage(UIImage(resource: .subtract), for: .normal)
        countryCodeButton.tintColor = .white
        countryCodeButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        countryCodeButton.translatesAutoresizingMaskIntoConstraints = false
        countryCodeButton.addTarget(self, action: #selector(choiseCodeButtonTapped), for: .touchUpInside)
        
        
        let rightPaddingView = UIView(frame: CGRect(x: -15, y: 0, width: 24, height: 24))
        rightPaddingView.addSubview(countryCodeButton)
        countryCodeButton.center = rightPaddingView.center
        
        codeTextField.rightView = rightPaddingView
        codeTextField.rightViewMode = .always
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
        let vc = RegisterVerificationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    @objc func choiseCodeButtonTapped(){
        print("choiseCodeButtonTapped")
    }
    
}

