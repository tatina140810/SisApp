import UIKit

class PasswordCodeCreate: UIViewController {
    
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
    private lazy var codeTextField: UITextField = {
        let textField = TextFieldSettings().textFieldMaker(
            placeholder: "",
            backgroundColor: UIColor(hex: "#1C192C"),
            cornerRadius: 26
        )
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
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
    
    let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFProText-Regular", size: 20) as Any,
        .foregroundColor: UIColor.white
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        backButtonSettings()
        navigationItem.title = "Код приложения"
        navigationController?.navigationBar.titleTextAttributes = attributes
        
    }
    private func setupUI(){
        
        view.addSubview(codeCreateLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(codeTextField)
        view.addSubview(skipButton)
        
        
        NSLayoutConstraint.activate([
            
            codeCreateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 168),
            codeCreateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: codeCreateLabel.bottomAnchor, constant: 47),
            subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            
            codeTextField.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 36),
            codeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            codeTextField.heightAnchor.constraint(equalToConstant: 52),
            codeTextField.widthAnchor.constraint(equalToConstant: 180),
            
            skipButton.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 28),
            skipButton.heightAnchor.constraint(equalToConstant: 56),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            
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
    
    @objc func skipButtonTapped(){
        let vc = AppEntryViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func textFieldDidChange() {
        if codeTextField.text?.count == 4 {
            navigateToAppEntry()
        }
    }
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    private func navigateToAppEntry() {
        
        let vc = AppEntryViewController()
        vc.codeCreatedButton.isHidden = false
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


