//
//  LightsTableViewCell.swift
//  Revisadinho
//
//  Created by Leonardo Gomes Fernandes on 19/10/21.
// swiftlint:disable trailing_whitespace

import UIKit

class LightTableViewCell: UITableViewCell {
    
    static let identifier = "LightTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .green
        frame.size = CGSize(width: UIScreen.main.bounds.width, height: 200)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
