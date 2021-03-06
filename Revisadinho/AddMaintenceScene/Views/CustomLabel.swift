//
//  CustomLabel.swift
//  Revisadinho
//
//  Created by Jéssica Araujo on 14/09/21.
//
// swiftlint:disable trailing_whitespace

import UIKit

class CustomLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func commomInit() {
        self.textColor = .grayText
        self.translatesAutoresizingMaskIntoConstraints = false
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 35),
            self.widthAnchor.constraint(equalToConstant: 300)
        ])
    }

}
