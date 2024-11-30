import UIKit

class AttributedTextHelper {
    
    static func configureAttributedText(
        for label: UILabel,
        fullText: String,
        tappableText: String,
        tapTarget: Any?,
        action: Selector
    ) {
        let attributedString = NSMutableAttributedString(string: fullText)
 
        let range = (fullText as NSString).range(of: tappableText)
      
        attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "#4CA2FF"), range: range)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        
       
        label.attributedText = attributedString
        
        let tapGesture = UITapGestureRecognizer(target: tapTarget, action: action)
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
    }
}
