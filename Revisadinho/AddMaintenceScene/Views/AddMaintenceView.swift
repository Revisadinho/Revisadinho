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
        scrollView.backgroundColor = .blueBackground
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
        collectionView.backgroundColor = .blueBackground
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
    
    var allMaintenceItems: [MaintenanceItem] = MaintenanceItem.allCases
    
    lazy var servicesSelected = [MaintenanceItem]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAddMaintenceView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupAddMaintenceView() {
        // dataSource = MaintenanceItem.allCases
        backgroundColor = .blueBackground
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
        titleLabel.textColor = .grayText
        titleLabel.font = UIFont(name: Fonts.bold, size: Fonts.sizeForTitles)
        
        calendarLabel.text = AddMaintenceViewStrings.calendarLabel
        calendarLabel.textAlignment = .left
        calendarLabel.textColor = .grayText
        calendarLabel.font = UIFont(name: Fonts.regular, size: Fonts.sizeForSubtitles)
        
        hodometerLabel.text = AddMaintenceViewStrings.hodometerLabel
        hodometerLabel.textAlignment = .left
        hodometerLabel.textColor = .grayText
        hodometerLabel.font = UIFont(name: Fonts.regular, size: Fonts.sizeForSubtitles)
        
        servicesLabel.text = AddMaintenceViewStrings.servicesLabel
        servicesLabel.textAlignment = .left
        servicesLabel.textColor = .grayText
        servicesLabel.font = UIFont(name: Fonts.regular, size: Fonts.sizeForSubtitles)
        
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(calendarLabel)
        scrollView.addSubview(hodometerLabel)
        scrollView.addSubview(servicesLabel)
    }
    
    private func setTextFields() {
        calendarTextField.placeholder = AddMaintenceViewStrings.calendarPlaceholder
        calendarTextField.setButtonWithIcon(AddMaintenceViewStrings.calendarIcon)
        calendarTextField.inputView = UIView()
        
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
}

// MARK: - CollectionView extensions

extension AddMaintenceView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allMaintenceItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "servicesCollectionViewCell", for: indexPath) as? ServicesCollectionViewCell else {return ServicesCollectionViewCell()}
        
        cell.setIconContents(withItem: allMaintenceItems[indexPath.item])
        return cell
    }
}

extension AddMaintenceView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            servicesSelected.append(allMaintenceItems[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if servicesSelected.contains(allMaintenceItems[indexPath.item]) {
            if let index = servicesSelected.firstIndex(where: {$0 == allMaintenceItems[indexPath.item]}) {
                    servicesSelected.remove(at: index)
                }
        }
    }
}

extension AddMaintenceView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 120)
    }
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
