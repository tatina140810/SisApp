//
//  VerificationViewController.swift
//  SisApp
//
//  Created by Tatina Dzhakypbekova on 1/12/24.
//

import UIKit

class VerificationViewController: UIViewController {
    
    private var verificationLabel: UILabel = {
        let label = UILabel()
        label.text = "Верификация"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите код из смс,\nчто мы отправили вам"
        label.textColor = UIColor(hex: "#CFCFCF")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var requestCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Запросить код можно\nчерез 05:00"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var firstTextField = TextFieldSettings().textFieldMaker(placeholder: "")
    private var secondTextField = TextFieldSettings().textFieldMaker(placeholder: "")
    private var thirdTextField = TextFieldSettings().textFieldMaker(placeholder: "")
    private var forthTextField = TextFieldSettings().textFieldMaker(placeholder: "")
    private var fifthTextField = TextFieldSettings().textFieldMaker(placeholder: "")
    private var sixthTextField = TextFieldSettings().textFieldMaker(placeholder: "")
    
    private lazy var entryButton: UIButton = {
        let button = ButtonSettings().buttonMaker(
            title: "Войти",
            target: self,
            action: #selector(entryButtonTapped)
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var didntReceiveTheCodeButton: UIButton = {
        let button = UIButton()

       
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 19.0),
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
 
        let buttonTitleStr = NSMutableAttributedString(
            string: "Я не получил код!",
            attributes: attrs
        )

        button.setAttributedTitle(buttonTitleStr, for: .normal)

        button.addTarget(self, action: #selector(didntReceiveTheCodeButtonTapped), for: .touchUpInside)

        button.backgroundColor = .black

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
        
        view.addSubview(verificationLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(requestCodeLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(firstTextField)
        stackView.addArrangedSubview(secondTextField)
        stackView.addArrangedSubview(thirdTextField)
        stackView.addArrangedSubview(forthTextField)
        stackView.addArrangedSubview(fifthTextField)
        stackView.addArrangedSubview(sixthTextField)
        view.addSubview(entryButton)
        view.addSubview(didntReceiveTheCodeButton)
        
        
        NSLayoutConstraint.activate([
            
            verificationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 168),
            verificationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: verificationLabel.bottomAnchor, constant: 17.67),
            subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          
            
            
            requestCodeLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 35),
            requestCodeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: requestCodeLabel.bottomAnchor, constant: 51),
            stackView.heightAnchor.constraint(equalToConstant: 46.24),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 302.44),
            
            entryButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 28),
            entryButton.heightAnchor.constraint(equalToConstant: 56),
            entryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            entryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            
            
            didntReceiveTheCodeButton.topAnchor.constraint(equalTo: entryButton.bottomAnchor, constant: 31),
           
            didntReceiveTheCodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
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
        let vc = EnterСodePasswordViewController() 
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func didntReceiveTheCodeButtonTapped(){
        let vc = DidntReceveTheCodeViewControlle()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}


