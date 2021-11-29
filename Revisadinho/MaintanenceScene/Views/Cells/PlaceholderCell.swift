//
//  PlaceholderCell.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 21/11/21.
//

import Foundation
import UIKit

class PlaceholderCell: UITableViewCell {
    
    static let identifier = "PlaceholderCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .blueBackground
        self.addSubview(placeholderText)
        self.selectionStyle = .none
        setUpPlaceholderConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var placeholderText: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .purpleDayNameCalendar
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "Quicksand-Bold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpPlaceholderConstraints() {
        NSLayoutConstraint.activate([
            placeholderText.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            placeholderText.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            placeholderText.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20),
            placeholderText.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
