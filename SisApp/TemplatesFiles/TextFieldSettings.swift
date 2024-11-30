import UIKit

class TextFieldSettings: UITextField {

    // Function to create and configure a text field
    func textFieldMaker(
        placeholder: String,
        placeholderColor: UIColor = .white,
        backgroundColor: UIColor = .black,
        textColor: UIColor = .white,
        cornerRadius: CGFloat = 8,
        autocapitalizationType: UITextAutocapitalizationType = .none
    ) -> UITextField {

        let textField = UITextField()

        textField.backgroundColor = backgroundColor
        textField.textColor = textColor
        textField.layer.cornerRadius = cornerRadius
        textField.autocapitalizationType = autocapitalizationType
        textField.translatesAutoresizingMaskIntoConstraints = false

        // Set placeholder with color
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )

        // Create gradient background
        let gradient = UIImage.gradientImage(bounds: textField.bounds, colors: [
            UIColor(hex: "#9358F7"),
            UIColor(hex: "#7B78F2"),
            UIColor(hex: "#6197EE"),
            UIColor(hex: "#45B5E9"),
            UIColor(hex: "#10D7E2")
        ])
        _ = UIColor(patternImage: gradient)

    
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        applyGradientBorder(to: textField, withColors: [UIColor(hex: "#9358F7"),
                                                       UIColor(hex: "#7B78F2"),
                                                       UIColor(hex: "#6197EE"),
                                                       UIColor(hex: "#45B5E9"),
                                                       UIColor(hex: "#10D7E2")])

        return textField
    }

    // Function to apply gradient to the border
    private func applyGradientBorder(to textField: UITextField, withColors colors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.colors = colors.map(\.cgColor)
        gradient.locations = [0.0, 1.0]

        // Set the frame of the gradient layer to match the text field bounds
        gradient.frame = CGRect(x: 0, y: 0, width: textField.bounds.width, height: textField.bounds.height)

        // Create a shape layer to act as the border
        let shape = CAShapeLayer()
        shape.lineWidth = 2
        shape.path = UIBezierPath(roundedRect: textField.bounds, cornerRadius: textField.layer.cornerRadius).cgPath
        shape.strokeColor = UIColor.black.cgColor // Optional: Set stroke color for fallback
        shape.fillColor = UIColor.white.cgColor

        // Apply the gradient to the border shape
        gradient.mask = shape

        // Add the gradient as a sublayer of the text field layer
        textField.layer.addSublayer(gradient)
        textField.layer.borderColor = UIColor(hex: "#6197EE").cgColor
        textField.borderStyle = .line
        textField.layer.borderWidth = 2
    }
}

extension UIImage {
    static func gradientImage(bounds: CGRect, colors: [UIColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map(\.cgColor)

        // This makes it left to right, default is top to bottom
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        let renderer = UIGraphicsImageRenderer(bounds: bounds)

        return renderer.image { ctx in
            gradientLayer.render(in: ctx.cgContext)
        }
    }
}

