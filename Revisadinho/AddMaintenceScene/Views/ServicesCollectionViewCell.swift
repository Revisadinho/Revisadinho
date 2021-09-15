//
//  ServicesCollectionViewCell.swift
//  Revisadinho
//
//  Created by Jéssica Araujo on 15/09/21.
//
// swiftlint:disable trailing_whitespace line_length

import UIKit

class ServicesCollectionViewCell: UICollectionViewCell {
    
    var iconImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 13
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.inactiveColor.cgColor
        
        iconImage.contentMode = .scaleAspectFit
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconImage)
        setConstraints()
    }
    
    public func setIconImage(withName iconName: String) {
        iconImage.image = UIImage(named: iconName)
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            iconImage.heightAnchor.constraint(equalToConstant: 40),
            iconImage.widthAnchor.constraint(equalToConstant: 40),
            iconImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
