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
    static let saveButtonLabel = "Salvar"
    static let bottomSheetButtonLabel = "Selecionar"
    static let calendarPlaceholder = "21 Agosto, 2021"
    static let hodometerPlaceholder = "30.000 km"
    static let calendarIcon = "calendar"
    static let speedometerIcon = "speedometer"
    static let chevronBackwardIcon = "chevron.backward"
    static let chevronForwardIcon = "chevron.forward"
}

class AddMaintenceView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .appBackgroundColor
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: Constants.scrollViewContentSize)
        return scrollView
    }()
    
    lazy var titleLabel = CustomLabel()
    lazy var calendarLabel = CustomLabel()
    lazy var hodometerLabel = CustomLabel()
    lazy var servicesLabel = CustomLabel()
    
    lazy var calendarTextField = CustomTextField()
    lazy var hodometerTextField = CustomTextField()
    
    lazy var saveButton = CustomButton()
    
    lazy var servicesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .appBackgroundColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
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
        dataSource = getServicesIcons()
        backgroundColor = .appBackgroundColor
        addSubview(scrollView)
        hideKeyboardWhenTappedAround()
        setLabels()
        setTextFields()
        setCollectionView()
        setButtons()
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
        
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(calendarLabel)
        scrollView.addSubview(hodometerLabel)
        scrollView.addSubview(servicesLabel)
    }
    
    private func setTextFields() {
        calendarTextField.placeholder = AddMaintenceViewStrings.calendarPlaceholder
        calendarTextField.setButtonWithIcon(AddMaintenceViewStrings.calendarIcon)
        
        hodometerTextField.placeholder = AddMaintenceViewStrings.hodometerPlaceholder
        hodometerTextField.setButtonWithIcon(AddMaintenceViewStrings.speedometerIcon)
        hodometerTextField.keyboardType = .numberPad
        
        scrollView.addSubview(calendarTextField)
        scrollView.addSubview(hodometerTextField)
    }
    
    private func setCollectionView() {
        servicesCollectionView.register(ServicesCollectionViewCell.self, forCellWithReuseIdentifier: "servicesCollectionViewCell")
        scrollView.addSubview(servicesCollectionView)
    }
    
    private func setButtons() {
        saveButton.setTitle(AddMaintenceViewStrings.saveButtonLabel, for: .normal)
        scrollView.addSubview(saveButton)
    }
    
    private func setContraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40),
            
            calendarLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            calendarLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            
            calendarTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            calendarTextField.topAnchor.constraint(equalTo: calendarLabel.bottomAnchor, constant: 8),
            
            hodometerLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            hodometerLabel.topAnchor.constraint(equalTo: calendarTextField.bottomAnchor, constant: 25),
            
            hodometerTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            hodometerTextField.topAnchor.constraint(equalTo: hodometerLabel.bottomAnchor, constant: 8),
            
            servicesLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            servicesLabel.topAnchor.constraint(equalTo: hodometerTextField.bottomAnchor, constant: 25),
            
            servicesCollectionView.topAnchor.constraint(equalTo: servicesLabel.bottomAnchor, constant: 8),
            servicesCollectionView.widthAnchor.constraint(equalToConstant: 300),
            servicesCollectionView.heightAnchor.constraint(equalToConstant: 250),
            servicesCollectionView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            saveButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: servicesCollectionView.bottomAnchor, constant: 40)
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

extension AddMaintenceView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "servicesCollectionViewCell", for: indexPath) as? ServicesCollectionViewCell else {return ServicesCollectionViewCell()}
        
        cell.setIconContents(withName: dataSource[indexPath.item])
        return cell
    }
}

extension AddMaintenceView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ServicesCollectionViewCell {
                cell.updateBorder()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ServicesCollectionViewCell {
                cell.updateBorder()
        }
    }
}

extension AddMaintenceView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 120)
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
    
    static var iconsBorderColor: UIColor = {
        return UIColor(displayP3Red: 232/255, green: 234/255, blue: 255/255, alpha: 1)
    }()
    
    static var secondColor: UIColor = {
        return UIColor(displayP3Red: 138/255, green: 142/255, blue: 176/255, alpha: 1)
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
        endEditing(true)
    }
}
