//
//  CustomButton.swift
//  Revisadinho
//
//  Created by Jéssica Araujo on 16/09/21.
//
// swiftlint:disable trailing_whitespace

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func commomInit() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .actionColor
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: Fonts.bold, size: Fonts.sizeForBody)
        layer.cornerRadius = 10
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40),
            widthAnchor.constraint(equalToConstant: 200)
        ])
    }

}
