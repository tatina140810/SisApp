import UIKit

@available(iOS 15.0, *)
class CountryCodeButton: UIButton, UIPickerViewDelegate, UIPickerViewDataSource {
    private var gradientColors: [UIColor]
    private let countryCodes: [String]
    private let pickerView = UIPickerView()
    private let popoverView = UIView()
    
    init(countryCodes: [String] = ["+7", "+380", "+375", "+998", "+996", "+992", "+993", "+994", "+1", "+44", "+91", "+86", "+49", "+33", "+81", "+39", "+61"],
         gradientColors: [UIColor] = [UIColor(hex: "#7113E3"), UIColor(hex: "#61C2E2")]) {
        self.countryCodes = countryCodes
        self.gradientColors = gradientColors
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false 
        setupButton()
        setupPickerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Button
    private func setupButton() {
        var config = UIButton.Configuration.plain()
        config.title = countryCodes.first
        config.image = UIImage(resource: .subtract)
        config.imagePlacement = .trailing
        config.imagePadding = 5
        config.baseForegroundColor = .white
        configuration = config
        
        layer.cornerRadius = 10
        layer.borderWidth = 1
        
        
        updateGradientBorder()
        
        addTarget(self, action: #selector(showPicker), for: .touchUpInside)
    }
    
    @objc private func updateGradientBorder() {
        guard bounds.size != .zero else { return }
        let gradientImage = UIImage.gradientImage(bounds: self.bounds, colors: gradientColors)
        let gradientColor = UIColor(patternImage: gradientImage)
        layer.borderColor = gradientColor.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientBorder()
    }
    
    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        popoverView.backgroundColor = UIColor(hex: "#181528")
        popoverView.layer.cornerRadius = 10
        popoverView.layer.shadowColor = UIColor.black.cgColor
        popoverView.layer.shadowOpacity = 0.2
        popoverView.layer.shadowRadius = 4
        popoverView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        popoverView.addSubview(pickerView)
        
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: popoverView.topAnchor),
            pickerView.leadingAnchor.constraint(equalTo: popoverView.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: popoverView.trailingAnchor),
            pickerView.bottomAnchor.constraint(equalTo: popoverView.bottomAnchor)
        ])
    }
    
    @objc private func showPicker() {
        guard let parentView = superview else { return }
        
        popoverView.frame = CGRect(x: frame.origin.x,
                                   y: frame.origin.y + frame.size.height + 8,
                                   width: frame.size.width,
                                   height: 150)
        parentView.addSubview(popoverView)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryCodes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryCodes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        configuration?.title = countryCodes[row]
        popoverView.removeFromSuperview()
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = countryCodes[row]
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ]
        return NSAttributedString(string: title, attributes: attributes)
    }
    
}
