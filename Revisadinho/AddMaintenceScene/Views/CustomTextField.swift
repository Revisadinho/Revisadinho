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
    static let fontSizeForTitles: CGFloat = 24
    static let fontSizeForSubtitles: CGFloat = 22
    static let fontRegular = "Quicksand-VariableFont_wght"
}

class CustomTextField: UITextField {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func commomInit() {
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.inactiveColor.cgColor
        self.layer.cornerRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(updateBorder), for: .allEditingEvents)
        setConstraints()
    }
    
    private func setPlaceholderColor() {
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [
                                                            NSAttributedString.Key.foregroundColor: placeholderColor])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: Constants.height),
            self.widthAnchor.constraint(equalToConstant: Constants.width)
        ])
    }
    
    @objc
    private func updateBorder() {
        let borderColor: UIColor = isFirstResponder ? .actionColor : .inactiveColor
        UIView.animate(withDuration: 0.25) {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
