
import UIKit

class AppEntryViewController: UIViewController {
    private let viewModel: AppEntryViewModelProtocol
    
    init(viewModel: AppEntryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    @objc private func appEntryButtonTapped() {
        viewModel.didTapAppEntryButton()
    }
    
}


