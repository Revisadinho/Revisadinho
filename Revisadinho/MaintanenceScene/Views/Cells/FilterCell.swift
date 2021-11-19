//
//  FilterCell.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 11/11/21.
//

import Foundation
import UIKit

protocol FilterButtonActionDelegate: AnyObject {
    func showDropDown(sender: Any)
}

class FilterCell: UITableViewCell {
    static let identifier = "FilterCell"
    weak var delegate: FilterButtonActionDelegate?
    
    lazy var filterView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        view.backgroundColor = .purpleAction
        view.layer.cornerRadius = 13
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var filterButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(delegatesFilterButtonActionToController(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func delegatesFilterButtonActionToController(sender: Any) {
        delegate?.showDropDown(sender: sender)
    }
    
    lazy var filterLabel: UILabel = {
        let label = UILabel()
        label.text = "6 meses"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "Quicksand-Bold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bottomArrowImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "cardExpansionIndicator")?.withTintColor(.white).withRenderingMode(.alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setUpViewHierarchy() {
        self.addSubview(filterView)
        filterView.addSubview(filterButton)
        filterView.addSubview(filterLabel)
        filterView.addSubview(bottomArrowImage)
    }
    
    func setUpFilterViewConstraints() {
        NSLayoutConstraint.activate([
            filterView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            filterView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10),
            filterView.widthAnchor.constraint(equalToConstant: filterView.frame.width),
            filterView.heightAnchor.constraint(equalToConstant: filterView.frame.height)
        ])
    }
    
    func setUpFilterButtonConstraints() {
        NSLayoutConstraint.activate([
            filterButton.leftAnchor.constraint(equalTo: filterView.leftAnchor),
            filterButton.rightAnchor.constraint(equalTo: filterView.rightAnchor),
            filterButton.topAnchor.constraint(equalTo: filterView.topAnchor),
            filterButton.bottomAnchor.constraint(equalTo: filterView.bottomAnchor)
        ])
    }
    
    func setUpFilterLabelConstraints() {
        NSLayoutConstraint.activate([
            filterLabel.leftAnchor.constraint(equalTo: filterButton.leftAnchor, constant: 20),
            filterLabel.centerYAnchor.constraint(equalTo: filterButton.centerYAnchor),
            filterLabel.rightAnchor.constraint(equalTo: bottomArrowImage.leftAnchor)
        ])
    }
    
    func setUpBottomArrowImageConstraints() {
        NSLayoutConstraint.activate([
            bottomArrowImage.rightAnchor.constraint(equalTo: filterButton.rightAnchor, constant: -15),
            bottomArrowImage.widthAnchor.constraint(equalToConstant: 15),
            bottomArrowImage.heightAnchor.constraint(equalToConstant: 15),
            bottomArrowImage.centerYAnchor.constraint(equalTo: filterButton.centerYAnchor)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .blueBackground
        self.selectionStyle = .none
        setUpViewHierarchy()
        setUpFilterViewConstraints()
        setUpFilterButtonConstraints()
        setUpFilterLabelConstraints()
        setUpBottomArrowImageConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
