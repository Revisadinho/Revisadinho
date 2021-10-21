//
//  LightsTableViewCell.swift
//  Revisadinho
//
//  Created by Leonardo Gomes Fernandes on 19/10/21.
// swiftlint:disable trailing_whitespace

import UIKit

class LightTableViewCell: UITableViewCell {
    
    static let identifier = "LightTableViewCell"
    
    lazy var iconImageView: UIImageView = {
       var icon = UIImageView()
//        icon.image = UIImage(named: "Icon")?.withRenderingMode(.alwaysOriginal)
        icon.contentMode = .scaleAspectFit
        icon.frame = CGRect(origin: .zero, size: CGSize(width: 40, height: 40))
        icon.backgroundColor = .blueBackground
        icon.layer.cornerRadius = 7
        icon.layer.borderWidth = 1
        icon.layer.borderColor = UIColor.borderServiceItem.cgColor
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    lazy var iconLabel: UILabel = {
        var label = UILabel()
//        label.text = "Item"
        label.textColor = .grayText
        label.font = UIFont(name: "Quicksand-Medium", size: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .blueBackground
        setUpIconImage()
        setUpLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpIconImage() {
        self.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            iconImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setUpLabel() {
        self.addSubview(iconLabel)
        
        NSLayoutConstraint.activate([
            iconLabel.heightAnchor.constraint(equalToConstant: 40),
            iconLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            iconLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor)
        ])
    }
    
}
