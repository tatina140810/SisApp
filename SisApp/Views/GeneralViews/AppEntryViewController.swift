//
//  AppEntryViewController.swift
//  SisApp
//
//  Created by Tatina Dzhakypbekova on 1/12/24.
//
import UIKit

class AppEntryViewController: UIViewController {
    
    lazy var codeCreatedButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(.white), for: .normal)
        button.setTitle("Вы успешно создали код\nприложения", for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(appEntryButtonTapped), for: .touchUpInside)
        button.backgroundColor = UIColor(hex: "#181528")
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
  
    private lazy var appEntryButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(hex: "#3796FD"), for: .normal)
        button.setTitle("Войти в приложение", for: .normal)
        button.addTarget(self, action: #selector(appEntryButtonTapped), for: .touchUpInside)
        button.backgroundColor = UIColor(hex: "#181528")
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
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
        view.addSubview(codeCreatedButton)
        view.addSubview(appEntryButton)
    
        NSLayoutConstraint.activate([
            codeCreatedButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 325),
            codeCreatedButton.heightAnchor.constraint(equalToConstant: 117.85),
            codeCreatedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            codeCreatedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            appEntryButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 467),
            appEntryButton.heightAnchor.constraint(equalToConstant: 68),
            appEntryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            appEntryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
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
    
    @objc func appEntryButtonTapped(){
       print("Вход в приложение")
    }
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}


