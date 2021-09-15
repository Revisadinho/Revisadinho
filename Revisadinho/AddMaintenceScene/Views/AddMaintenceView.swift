//
//  AddMaintenceView.swift
//  Revisadinho
//
//  Created by Jéssica Araujo on 14/09/21.
//
// swiftlint:disable trailing_whitespace line_length

import UIKit

public enum AddMaintenceViewStrings {
    static let title = "Nova Manutenção"
    static let calendarLabel = "Selecione a data"
    static let hodometerLabel = "Km do veículo"
    static let servicesLabel = "Serviços"
    static let calendarPlaceholder = "21 Agosto, 2021"
    static let hodometerPlaceholder = "30.000 km"
    static let calendarIcon = "calendar"
    static let speedometerIcon = "speedometer"
}

class AddMaintenceView: UIView {
    
    private let titleLabel = CustomLabel()
    private let calendarLabel = CustomLabel()
    private let hodometerLabel = CustomLabel()
    private let servicesLabel = CustomLabel()
    
    private let calendarTextField = CustomTextField()
    private let hodometerTextField = CustomTextField()
    
    lazy var servicesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 40
        layout.minimumLineSpacing = 40
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .appBackgroundColor
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    var dataSource = [String]() {
        didSet {
            servicesCollectionView.reloadData()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAddMaintenceView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupAddMaintenceView() {
        self.dataSource = getServicesIcons()
        self.backgroundColor = .appBackgroundColor
        self.hideKeyboardWhenTappedAround()
        setLabels()
        setTextFields()
        setCollectionView()
        setContraints()
    }
    
    private func setLabels() {
        titleLabel.text = AddMaintenceViewStrings.title
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: Fonts.bold, size: Fonts.sizeForTitles)
        
        calendarLabel.text = AddMaintenceViewStrings.calendarLabel
        calendarLabel.textAlignment = .left
        calendarLabel.font = UIFont(name: Fonts.regular, size: Fonts.sizeForSubtitles)
        
        hodometerLabel.text = AddMaintenceViewStrings.hodometerLabel
        hodometerLabel.textAlignment = .left
        hodometerLabel.font = UIFont(name: Fonts.regular, size: Fonts.sizeForSubtitles)
        
        servicesLabel.text = AddMaintenceViewStrings.servicesLabel
        servicesLabel.textAlignment = .left
        servicesLabel.font = UIFont(name: Fonts.regular, size: Fonts.sizeForSubtitles)
        
        addSubview(titleLabel)
        addSubview(calendarLabel)
        addSubview(hodometerLabel)
        addSubview(servicesLabel)
    }
    
    private func setTextFields() {
        calendarTextField.placeholder = AddMaintenceViewStrings.calendarPlaceholder
        calendarTextField.setButtonWithIcon(AddMaintenceViewStrings.calendarIcon)
        
        hodometerTextField.placeholder = AddMaintenceViewStrings.hodometerPlaceholder
        hodometerTextField.setButtonWithIcon(AddMaintenceViewStrings.speedometerIcon)
        hodometerTextField.keyboardType = .numberPad
        
        addSubview(calendarTextField)
        addSubview(hodometerTextField)
    }
    
    private func setCollectionView() {
        servicesCollectionView.register(ServicesCollectionViewCell.self, forCellWithReuseIdentifier: "servicesCollectionViewCell")
        addSubview(servicesCollectionView)
    }
    
    private func setContraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            
            calendarLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            calendarLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            
            calendarTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            calendarTextField.topAnchor.constraint(equalTo: calendarLabel.bottomAnchor, constant: 8),
            
            hodometerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            hodometerLabel.topAnchor.constraint(equalTo: calendarTextField.bottomAnchor, constant: 25),
            
            hodometerTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            hodometerTextField.topAnchor.constraint(equalTo: hodometerLabel.bottomAnchor, constant: 8),
            
            servicesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            servicesLabel.topAnchor.constraint(equalTo: hodometerTextField.bottomAnchor, constant: 25),
            
            servicesCollectionView.topAnchor.constraint(equalTo: servicesLabel.bottomAnchor, constant: 8),
            servicesCollectionView.widthAnchor.constraint(equalToConstant: 300),
            servicesCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            servicesCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30)
        ])
    }
    
    private func getServicesIcons() -> [String] {
        var servicesIcons = [String]()
        let paths = Bundle.main.paths(forResourcesOfType: "png", inDirectory: "ServicesIcons")
        for path in paths {
            let fileName = URL(fileURLWithPath: path).deletingPathExtension().lastPathComponent
            servicesIcons.append(fileName)
        }
        
        return servicesIcons
    }
}

// MARK: - CollectionView extensions

extension AddMaintenceView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "servicesCollectionViewCell", for: indexPath) as? ServicesCollectionViewCell else {return ServicesCollectionViewCell()}
        
        cell.setIconImage(withName: dataSource[indexPath.item])
        return cell
    }
}

extension AddMaintenceView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 70, height: 70)
    }
}

// MARK: - Temporary UIColor extension

extension UIColor {
    static var appBackgroundColor: UIColor = {
        return UIColor(displayP3Red: 249/255, green: 251/255, blue: 252/255, alpha: 1)
    }()
    
    static var actionColor: UIColor = {
        return UIColor(displayP3Red: 150/255, green: 121/255, blue: 247/255, alpha: 1)
    }()
    
    static var inactiveColor: UIColor = {
        return .gray
    }()
    
    static var mainColor: UIColor = {
       return UIColor(displayP3Red: 61/255, green: 60/255, blue: 80/255, alpha: 1)
    }()
}

// MARK: - Temporary UIView extension

extension UIView {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }
    
    @objc
    func dismissKeyboard() {
        self.endEditing(true)
    }
}
