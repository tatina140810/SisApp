import UIKit

class ButtonSettings: UIButton {
    
    private var gradientColors: [UIColor] = [
        UIColor(hex: "#9358F7"),
        UIColor(hex: "#7B78F2"),
        UIColor(hex: "#6197EE"),
        UIColor(hex: "#45B5E9"),
        UIColor(hex: "#10D7E2")
    ]
    private var cornerRadius: CGFloat = 28
    private var gradientLayer: CAGradientLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradientBackground()
        if isEnabled {
            applyGradientBackground()
        } else {
            gradientLayer?.removeFromSuperlayer() 
            gradientLayer = nil
        }
    }
    
    func buttonMaker(title: String = "Button",
                     titleColor: UIColor = .white,
                     target: Any?,
                     action: Selector,
                     for controlEvent: UIControl.Event = .touchUpInside) -> UIButton {
        
        let button = ButtonSettings()
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.layer.cornerRadius = cornerRadius
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 16)
        button.addTarget(target, action: action, for: controlEvent)
        
        return button
    }
    
    private func applyGradientBackground() {
        
        gradientLayer?.removeFromSuperlayer()
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = cornerRadius
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        
        self.gradientLayer = gradientLayer
    }
}
