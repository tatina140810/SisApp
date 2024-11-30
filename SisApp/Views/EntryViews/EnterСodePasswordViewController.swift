//
//  enter СodePasswordViewController.swift
//  SisApp
//
//  Created by Tatina Dzhakypbekova on 1/12/24.
//

import UIKit

class EnterСodePasswordViewController: UIViewController {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите код - пароль"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Bold", size: 24)
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
        
        view.addSubview(titleLabel)

        view.addSubview(codeTextField)

        
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 210),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
           
            
            codeTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            codeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            codeTextField.heightAnchor.constraint(equalToConstant: 52),
            codeTextField.widthAnchor.constraint(equalToConstant: 180)
            
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
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


