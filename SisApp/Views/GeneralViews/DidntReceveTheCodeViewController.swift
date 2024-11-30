import UIKit

class DidntReceveTheCodeViewControlle: UIViewController {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Не пришел код?"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "SFProDisplay-Regular", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
 
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Обратитесь в чат\nподдержки"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var chatButton: UIButton = {
        let button = ButtonSettings().buttonMaker(
            title: "Чат поддержки",
            target: self,
            action: #selector(chatButtonTapped)
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        backButtonSettings()
    }
    private func setupUI(){
        
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(chatButton)
     
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 157),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
            chatButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 53),
            chatButton.heightAnchor.constraint(equalToConstant: 56),
            chatButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            chatButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35)
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
    
    @objc func chatButtonTapped(){
       print("Чат поддержки")
    }
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

