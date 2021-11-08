//
//  LightsTableViewCell.swift
//  Revisadinho
//
//  Created by Leonardo Gomes Fernandes on 19/10/21.
// swiftlint:disable trailing_whitespace line_length

import UIKit

class LightTableViewCell: UITableViewCell {
    
    static let identifier = "LightTableViewCell"
    var isOpen: Bool = false
    
    let iconImageView: UIImageView = {
       var icon = UIImageView()
        icon.image = UIImage(named: "temperatura_transmissão")?.withRenderingMode(.alwaysOriginal)
        icon.contentMode = .scaleAspectFit
//        icon.frame = CGRect(origin: .zero, size: CGSize(width: 36, height: 36))
        icon.backgroundColor = .blueBackground
        icon.layer.cornerRadius = 7
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    lazy var imageContainer: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 7
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.borderServiceItem.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var iconLabel: UILabel = {
        var label = UILabel()
        label.textColor = .grayText
        label.font = UIFont(name: "Quicksand-Medium", size: 19)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        var label = UILabel()
//        label.text = "Item"
        label.textColor = .grayText
        label.numberOfLines = 0
        label.font = UIFont(name: "Quicksand-Regular", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let container: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .blueBackground
        return view
    }()
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        imageContainer.layer.borderColor = UIColor.borderServiceItem.cgColor
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .blueBackground
        setUpContainerView()
        setUpimageContainer()
        setUpimageView()
        setUpLabel()
        setUpDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selected() {
        isOpen.toggle()
    }
    
    func animate() {
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.contentView.layoutIfNeeded()
        }
    }
    
    func setUpContainerView() {
        self.contentView.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func setUpimageContainer() {
        container.addSubview(imageContainer)
        
        NSLayoutConstraint.activate([
            imageContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            imageContainer.topAnchor.constraint(equalTo: container.topAnchor),
            imageContainer.widthAnchor.constraint(equalToConstant: 40),
            imageContainer.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    func setUpimageView() {
        imageContainer.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: imageContainer.topAnchor, constant: 8),
            iconImageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor, constant: 8),
            iconImageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: -8),
            iconImageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: -8)
        
        ])
    }
    
    func setUpLabel() {
        container.addSubview(iconLabel)
        
        NSLayoutConstraint.activate([
            iconLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            iconLabel.leadingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: 12),
            iconLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            iconLabel.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor)
        ])
    }
    
    func setUpDescriptionLabel() {
        container.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: iconLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: iconLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
    
}
