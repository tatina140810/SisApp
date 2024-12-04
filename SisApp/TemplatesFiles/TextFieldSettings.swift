import UIKit

class GradientTextField: UITextField {
    
    private var gradientColors: [UIColor]
    private var borderWidth: CGFloat
    
    init(
        placeholder: String,
        font: UIFont = UIFont(name: "SFProText-Medium", size: 19)!,
        gradientColors: [UIColor] = [UIColor(hex: "#7113E3"), UIColor(hex: "#61C2E2")],
        translatesAutoresizingMaskIntoConstraints: Bool = false,
        cornerRadius: CGFloat = 10,
        textAlignment: NSTextAlignment = .left
    ) {
        
        self.gradientColors = gradientColors
        self.borderWidth = 1.5
        
        super.init(frame: .zero)
        
        
        self.backgroundColor = backgroundColor
        self.textColor = .white
        self.layer.cornerRadius = cornerRadius
        self.textAlignment = textAlignment
        self.keyboardType = .numberPad
        self.translatesAutoresizingMaskIntoConstraints = false
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#B0B0B0")]
        )
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.font = font
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        applyGradientBorder()
    }
    
    private func applyGradientBorder() {
        guard self.bounds.size != .zero else { return }
        
        let gradientImage = UIImage.gradientImage(bounds: self.bounds, colors: gradientColors)
        let gradientColor = UIColor(patternImage: gradientImage)
        self.layer.borderColor = gradientColor.cgColor
        self.layer.borderWidth = borderWidth
    }
}

extension UIImage {
    static func gradientImage(bounds: CGRect, colors: [UIColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        gradientLayer.render(in: context)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return gradientImage ?? UIImage()
    }
}
extension GradientTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
