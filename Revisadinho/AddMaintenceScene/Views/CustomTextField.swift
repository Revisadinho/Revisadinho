//
//  CustomTextField.swift
//  Revisadinho
//
//  Created by Jéssica Araujo on 14/09/21.
//
// swiftlint:disable trailing_whitespace line_length

import UIKit

public enum Constants {
    static let offset: CGFloat = 8
    static let placeholderSize: CGFloat = 16
    static let height: CGFloat = 60
    static let width: CGFloat = 300
    static let scrollViewContentSize: CGFloat = 800
   
}

public enum Fonts {
    static let regular = "Quicksand-Regular"
    static let bold = "Quicksand-Bold"
    static let medium = "Quicksand-Medium"
    static let light = "Quicksand-Light"
    static let semiBold = "Quicksand-SemiBold"
    static let sizeForTitles: CGFloat = 24
    static let sizeForSubtitles: CGFloat = 20
    static let sizeForBody: CGFloat = 15
    static let sizeForWeekdayCalendar: CGFloat = 12
}

class CustomTextField: UITextField {
    
    private let symbolButton = UIButton(type: .custom)
    
    private var textHeight: CGFloat {
        ceil(font?.lineHeight ?? 0)
    }
    
    private var textInsets: UIEdgeInsets {
        UIEdgeInsets(top: Constants.offset, left: Constants.offset, bottom: Constants.offset, right: 0)
    }
    
    var placeholderColor: UIColor = .inactiveColor {
        didSet {
            self.setPlaceholderColor()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.width, height: textInsets.top + textHeight + textInsets.bottom)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= self.textInsets.left
        return rect
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func commomInit() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.purpleAction.cgColor
        self.layer.cornerRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: Fonts.medium, size: Fonts.sizeForBody)
        textColor = UIColor.grayText
        addTarget(self, action: #selector(updateColors), for: .allEditingEvents)
        setConstraints()
    }
    
    public func setButtonWithIcon(_ icon: String) {
        let largeConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .default)
        let icon = UIImage(systemName: icon, withConfiguration: largeConfiguration)
        symbolButton.setImage(icon, for: .normal)
        symbolButton.frame = CGRect(x: CGFloat(self.frame.size.width - 40), y: CGFloat(5), width: CGFloat(32), height: CGFloat(32))
        symbolButton.tintColor = .purpleAction
        self.rightView = symbolButton
        self.rightViewMode = .always
    }
    
    private func setPlaceholderColor() {
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.grayText])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: Constants.height),
            self.widthAnchor.constraint(equalToConstant: Constants.width)
        ])
    }
    
    @objc
    private func updateColors() {
        let currentColor: UIColor = isFirstResponder ? .purpleAction : .inactiveColor
        UIView.animate(withDuration: 0.25) {
            self.layer.borderColor = currentColor.cgColor
            self.symbolButton.tintColor = currentColor
        }
    }
}
