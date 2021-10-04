//
//  MaintenanceCell.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 15/09/21.
// swiftlint:disable trailing_whitespace line_length

import Foundation
import UIKit

class MaintenanceTableViewCell: UITableViewCell {
    
    static var identifier = "MaintenanceTableViewCell"
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "20 Setembro, 2021"
        label.textColor = .grayText
        label.font = UIFont(name: "Quicksand-Medium", size: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var circle: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 13.42))
        view.layer.cornerRadius = view.layer.bounds.width / 2
        view.clipsToBounds = true
        view.backgroundColor = .blueTabBar
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lineBottom: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: self.frame.height))
        view.backgroundColor = .blueTabBar
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lineUp: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: self.frame.height))
        view.backgroundColor = .blueTabBar
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cardCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 330, height: 130), collectionViewLayout: MaintenanceCollectionViewCell.collectionViewLayout())
        collectionView.register(MaintenanceCollectionViewCell.self, forCellWithReuseIdentifier: MaintenanceCollectionViewCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = 15
        collectionView.layer.shadowColor = UIColor.black.cgColor
        collectionView.layer.shadowOpacity = 0.1
        collectionView.layer.shadowOffset = .zero
        collectionView.layer.shadowRadius = 5
        collectionView.layer.masksToBounds = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func setUpDateLabelConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            dateLabel.widthAnchor.constraint(equalToConstant: 200),
            dateLabel.heightAnchor.constraint(equalToConstant: 41),
            dateLabel.leftAnchor.constraint(equalTo: circle.leftAnchor, constant: 24)
        ])
    }
    
    func setUpCircleConstraints() {
        NSLayoutConstraint.activate([
            circle.topAnchor.constraint(equalTo: dateLabel.topAnchor, constant: 13.5),
            circle.widthAnchor.constraint(equalToConstant: 13),
            circle.heightAnchor.constraint(equalToConstant: 13.42),
            circle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24)
        ])
    }
    
    func setUpLineBottomConstraints() {
        NSLayoutConstraint.activate([
            lineBottom.topAnchor.constraint(equalTo: circle.bottomAnchor),
            lineBottom.widthAnchor.constraint(equalToConstant: 1),
            lineBottom.heightAnchor.constraint(equalTo: self.heightAnchor),
            lineBottom.centerXAnchor.constraint(equalTo: circle.centerXAnchor)
        ])
    }
    
    func setUpLineUpConstraints() {
        NSLayoutConstraint.activate([
            lineUp.topAnchor.constraint(equalTo: self.topAnchor),
            lineUp.widthAnchor.constraint(equalToConstant: 1),
            lineUp.heightAnchor.constraint(equalTo: self.heightAnchor),
            lineUp.centerXAnchor.constraint(equalTo: circle.centerXAnchor)
        ])
    }
    
    func setUpCardViewConstraints() {
        NSLayoutConstraint.activate([
            cardCollectionView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            cardCollectionView.heightAnchor.constraint(equalToConstant: 130),
            cardCollectionView.leftAnchor.constraint(equalTo: circle.leftAnchor, constant: 24),
            cardCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)
        ])
    }
    
    func setUpViewHierarchy() {
        self.addSubview(dateLabel)
        self.addSubview(cardCollectionView)
        self.addSubview(circle)
        self.addSubview(lineBottom)
        self.addSubview(lineUp)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .blueBackground
        self.selectionStyle = .none
        setUpViewHierarchy()
        setUpDateLabelConstraints()
        setUpCardViewConstraints()
        setUpCircleConstraints()
        setUpLineBottomConstraints()
        setUpLineUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
