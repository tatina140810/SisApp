import UIKit

class MainViewController: UIViewController {
    
    private let viewModel: MainViewModelProtocol
    
    private var logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .group63)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Medium", size: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Regular", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var entryButton: UIButton = {
        let button = ButtonSettings().buttonMaker(
            title: "Войти по номеру телефона",
            target: self,
            action: #selector(entryButtonTapped)
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var noAccauntLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProText-Regular", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(viewModel: MainViewModelProtocol){
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
        createAttributedText()
    }
    private func setupUI(){
        view.addSubview(logoImage)
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(entryButton)
        view.addSubview(noAccauntLabel)
        
        titleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.subTitle
        noAccauntLabel.text = viewModel.noAccountText
        
        NSLayoutConstraint.activate([
            
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 215),
            logoImage.widthAnchor.constraint(equalToConstant: 105),
            logoImage.heightAnchor.constraint(equalToConstant: 105.27),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 31.73),
            
            subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 17.67),
            
            
            entryButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 99.85),
            entryButton.heightAnchor.constraint(equalToConstant: 56),
            entryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            entryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            
            noAccauntLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noAccauntLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -89)
        ])
        
    }
    
    @objc func entryButtonTapped(){
        viewModel.handleEntryButtonTapped()
        
    }
    private func createAttributedText() {
        AttributedTextHelper.configureAttributedText(
            for: noAccauntLabel,
            fullText: "У вас нет аккаунта?\nЗарегистрируйтесь сейчас",
            tappableText: "Зарегистрируйтесь сейчас",
            tapTarget: self,
            action: #selector(attributedPrivaciTextTapped)
        )
    }
    @objc func attributedPrivaciTextTapped(){
        viewModel.handleNoAccauntTapped()
    }
    
    
}

