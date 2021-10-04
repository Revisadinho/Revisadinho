//
//  ServicesCollectionViewCell.swift
//  Revisadinho
//
//  Created by Jéssica Araujo on 15/09/21.
//
// swiftlint:disable trailing_whitespace

import UIKit

class ServicesCollectionViewCell: UICollectionViewCell {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if self.isSelected {
            iconView.layer.borderColor = UIColor.purpleAction.cgColor
            iconView.layer.borderWidth = 1.5
        } else {
            iconView.layer.borderColor = UIColor.borderServiceItem.cgColor
            iconView.layer.borderWidth = 1
        }
    }
    lazy var iconView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.borderServiceItem.cgColor
        view.backgroundColor = .monthCardBackground
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
        label.font = UIFont(name: Fonts.medium, size: 13.7)
        label.textColor = .grayText
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                iconView.layer.borderColor = UIColor.purpleAction.cgColor
                iconView.layer.borderWidth = 1.5
            } else {
                iconView.layer.borderColor = UIColor.borderServiceItem.cgColor
                iconView.layer.borderWidth = 1
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.backgroundColor = .blueBackground
        
        addSubview(iconView)
        addSubview(iconLabel)
        iconView.addSubview(iconImageView)
        
        setConstraints()
    }
    
    public func setIconContents(withItem item: MaintenanceItem) {
        iconImageView.image = UIImage(named: "\(item)")
        iconLabel.text = item.description
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
            iconLabel.widthAnchor.constraint(equalToConstant: 105),
            iconLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            iconLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

extension UICollectionView {
    func deselectAllItems(animated: Bool = false) {
        for indexPath in self.indexPathsForSelectedItems ?? [] {
            self.deselectItem(at: indexPath, animated: animated)
       }
    }
}
