import UIKit

class GradientTextView: UIView {
    
    private var text: String
    private var font: UIFont
    private var gradientColors: [UIColor]
    
    init(frame: CGRect, text: String, font: UIFont, gradientColors: [UIColor]) {
        self.text = text
        self.font = font
        self.gradientColors = gradientColors
        super.init(frame: frame)
        setupGradientText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGradientText() {
        var currentX: CGFloat = 0
        
        for char in text {
            let charSize = String(char).size(withAttributes: [.font: font])
            
            let textLayer = CATextLayer()
            textLayer.string = String(char)
            textLayer.font = font
            textLayer.fontSize = font.pointSize
            textLayer.foregroundColor = UIColor.white.cgColor
            textLayer.frame = CGRect(x: currentX, y: 0, width: charSize.width, height: charSize.height)
            textLayer.contentsScale = UIScreen.main.scale
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = textLayer.frame
            gradientLayer.colors = gradientColors.map { $0.cgColor }
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            
           
            gradientLayer.mask = textLayer
            self.layer.addSublayer(gradientLayer)
            
            currentX += charSize.width
        }
    }
}
