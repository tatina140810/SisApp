import UIKit


class ButtonSettings: UIButton {

    let gradientColors: [UIColor] = [
        UIColor(hex: "#9358F7"),
        UIColor(hex: "#7B78F2"),
        UIColor(hex: "#6197EE"),
        UIColor(hex: "#45B5E9"),
        UIColor(hex: "#10D7E2")
    ]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradientToButton(colors: gradientColors)
    }
    
    func buttonMaker(title: String = "Button",
                     titleColor: UIColor = .white,
                     target: Any?,
                     action: Selector,
                     for controlEvent: UIControl.Event = .touchUpInside) -> UIButton {
        
        let button = ButtonSettings()
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.layer.cornerRadius = 28
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 16)
        button.addTarget(target, action: action, for: controlEvent)
        
        return button
    }

    private func applyGradientToButton(colors: [UIColor], locations: [NSNumber]? = nil, startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 1, y: 1)) {
        
        if let existingGradientLayer = self.layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            existingGradientLayer.removeFromSuperlayer()
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

