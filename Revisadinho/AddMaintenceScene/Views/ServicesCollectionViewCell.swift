//
//  ServicesCollectionViewCell.swift
//  Revisadinho
//
//  Created by Jéssica Araujo on 15/09/21.
//
// swiftlint:disable trailing_whitespace

import UIKit

class ServicesCollectionViewCell: UICollectionViewCell {
    
    lazy var iconView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.iconsBorderColor.cgColor
        return view
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var iconLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.light, size: 13)
        label.textColor = .mainColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.backgroundColor = .appBackgroundColor
        
        addSubview(iconView)
        addSubview(iconLabel)
        iconView.addSubview(iconImageView)
        
        setConstraints()
    }
    
    public func setIconContents(withItem item: MaintenanceItem) {
        iconImageView.image = UIImage(named: "\(item)")
        iconLabel.text = item.description
    }
    
    public func updateBorder() {
        let newColor: UIColor = isSelected ? .actionColor : .iconsBorderColor
        UIView.animate(withDuration: 0.25) {
            self.iconView.layer.borderColor = newColor.cgColor
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 60),
            iconView.heightAnchor.constraint(equalToConstant: 60),
            iconView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            iconView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.centerXAnchor.constraint(equalTo: iconView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            
            iconLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 5),
            iconLabel.widthAnchor.constraint(equalToConstant: 95),
            iconLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            iconLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
