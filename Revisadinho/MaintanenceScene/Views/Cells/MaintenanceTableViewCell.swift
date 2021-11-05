//
//  MaintenanceCell.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 15/09/21.
// swiftlint:disable trailing_whitespace line_length

import Foundation
import UIKit

class MaintenanceTableViewCell: UITableViewCell {
    
//    static var cellHeight = 249
    static var cellHeight = 255
    static var collectionViewHeight = 130
    static var identifier = "MaintenanceTableViewCell"
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "20 Setembro, 2021"
        label.textColor = .grayText
        label.font = UIFont(name: "Quicksand-Medium", size: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var viewForHidingExcedentLineOfFirstCell: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: self.frame.height))
        view.backgroundColor = .blueBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cardCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 330, height: MaintenanceTableViewCell.collectionViewHeight), collectionViewLayout: MaintenanceCollectionViewCell.collectionViewLayout())
        collectionView.register(MaintenanceCollectionViewCell.self, forCellWithReuseIdentifier: MaintenanceCollectionViewCell.identifier)
        collectionView.backgroundColor = .monthCardBackground
        collectionView.layer.cornerRadius = 15
        collectionView.layer.shadowColor = UIColor.black.cgColor
        collectionView.layer.shadowOpacity = 0.1
        collectionView.layer.shadowOffset = .zero
        collectionView.layer.shadowRadius = 5
        collectionView.layer.masksToBounds = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var hodometerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "speedometer")?.withTintColor(.purpleDayNameCalendar).withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var cardExpansionIndicator: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "cardExpansionIndicator")
//        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var hodometerLabel: UILabel = {
        let label = UILabel()
        label.text = "5000 km"
        label.textColor = .purpleDayNameCalendar
        label.font = UIFont(name: "Quicksand-Medium", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpViewForHidingLineConstraints() {
        NSLayoutConstraint.activate([
            viewForHidingExcedentLineOfFirstCell.topAnchor.constraint(equalTo: self.topAnchor),
            viewForHidingExcedentLineOfFirstCell.widthAnchor.constraint(equalToConstant: 3 ),
            viewForHidingExcedentLineOfFirstCell.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
            viewForHidingExcedentLineOfFirstCell.bottomAnchor.constraint(equalTo: circle.topAnchor)
        ])
    }
    
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
            lineBottom.topAnchor.constraint(equalTo: self.topAnchor),
            lineBottom.widthAnchor.constraint(equalToConstant: lineBottom.frame.width),
            lineBottom.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
            lineBottom.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setUpCardViewConstraints() {
        NSLayoutConstraint.activate([
            cardCollectionView.topAnchor.constraint(equalTo: hodometerImage.bottomAnchor, constant: 20),
            cardCollectionView.leftAnchor.constraint(equalTo: circle.leftAnchor, constant: 24),
            cardCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            cardCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
    func setUpHodometerImageConstraints() {
        NSLayoutConstraint.activate([
            hodometerImage.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 6),
            hodometerImage.leftAnchor.constraint(equalTo: dateLabel.leftAnchor),
            hodometerImage.widthAnchor.constraint(equalToConstant: 23),
            hodometerImage.heightAnchor.constraint(equalToConstant: 23)
        ])
    }
    
    func setUpCardExpansionIndicatorConstraints() {
        NSLayoutConstraint.activate([
            cardExpansionIndicator.widthAnchor.constraint(equalToConstant: 15),
            cardExpansionIndicator.heightAnchor.constraint(equalToConstant: 15),
            cardExpansionIndicator.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
            cardExpansionIndicator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
        ])
    }
    
    func setUpHodometerLabelConstraints() {
        NSLayoutConstraint.activate([
            hodometerLabel.centerYAnchor.constraint(equalTo: hodometerImage.centerYAnchor),
            hodometerLabel.leftAnchor.constraint(equalTo: hodometerImage.rightAnchor, constant: 8),
            hodometerLabel.widthAnchor.constraint(equalToConstant: 100),
            hodometerLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lineBottom.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        setUpDashedLayer()
    }

    func setUpViewHierarchy() {
        self.addSubview(dateLabel)
        self.addSubview(cardCollectionView)
        cardCollectionView.addSubview(cardExpansionIndicator)
        self.addSubview(hodometerImage)
        self.addSubview(hodometerLabel)
        self.addSubview(circle)
        self.addSubview(lineBottom)
        self.addSubview(viewForHidingExcedentLineOfFirstCell)
    }
    
    func animate() {
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.contentView.layoutIfNeeded()
        }
    }
    
    func setUpDashedLayer() {
        let layer = CALayer()
        let lineDashPattern:[NSNumber] = [5, 3]
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.blueTabBar.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = lineDashPattern

        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: lineBottom.frame.minY),
                                CGPoint(x: 0, y: lineBottom.frame.maxY)])
        shapeLayer.path = path
        shapeLayer.frame = lineBottom.bounds
        layer.addSublayer(shapeLayer)
        lineBottom.layer.addSublayer(layer)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .blueBackground
        self.selectionStyle = .none
        setUpViewHierarchy()
        setUpDateLabelConstraints()
        setUpCardViewConstraints()
        setUpCardExpansionIndicatorConstraints()
        setUpHodometerImageConstraints()
        setUpHodometerLabelConstraints()
        setUpCircleConstraints()
        setUpLineBottomConstraints()
        setUpViewForHidingLineConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
