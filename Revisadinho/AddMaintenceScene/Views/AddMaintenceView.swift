//
//  AddMaintenceView.swift
//  Revisadinho
//
//  Created by Jéssica Araujo on 14/09/21.
//

import UIKit

public enum AddMaintenceViewStrings {
    static let title = "Nova Manutenção"
    static let calendarLabel = "Selecione a data"
    static let hodometerLabel = "Km do veículo"
    static let servicesLabel = "Serviços"
    static let saveButtonLabel = "Salvar"
    static let cancelButtonLabel = "Cancelar"
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

    let pageControl: UIPageControl = {
        let pageControll = UIPageControl()
        pageControll.backgroundStyle = .automatic
        pageControll.translatesAutoresizingMaskIntoConstraints = false
        pageControll.isUserInteractionEnabled = false
        return pageControll
    }()
    
    lazy var servicesCollectionView: UICollectionView = {
        let layout = CustomCollectionFlowLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .blueBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = .blueBackground
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
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
        allMaintenceItems = allMaintenceItems.sorted {
            $0.description.folding(options: .diacriticInsensitive, locale: .current) < $1.description.folding(options: .diacriticInsensitive, locale: .current)
        }
        setupAddMaintenceView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupAddMaintenceView() {
        // dataSource = MaintenanceItem.allCases
        backgroundColor = .blueBackground
        scrollView.delegate = self
        addSubview(scrollView)
        servicesCollectionView.flashScrollIndicators()
        hideKeyboardWhenTappedAround()
        setLabels()
        setTextFields()
        setCollectionView()
        setPageControll()
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
    
    private func setPageControll() {
        scrollView.addSubview(pageControl)
    }
    
    private func setButtons() {
        saveButton.setTitle(AddMaintenceViewStrings.saveButtonLabel, for: .normal)
        addSubview(saveButton)
    }
    
    private func setContraints() {
        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
        
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleLabel.topAnchor.constraint(lessThanOrEqualTo: scrollView.topAnchor, constant: 15),
            
            calendarLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            calendarLabel.topAnchor.constraint(lessThanOrEqualTo: titleLabel.bottomAnchor, constant: 15),
            
            calendarTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            calendarTextField.topAnchor.constraint(lessThanOrEqualTo: calendarLabel.bottomAnchor, constant: 5),
            
            hodometerLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            hodometerLabel.topAnchor.constraint(lessThanOrEqualTo: calendarTextField.bottomAnchor, constant: 15),
            
            hodometerTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            hodometerTextField.topAnchor.constraint(lessThanOrEqualTo: hodometerLabel.bottomAnchor, constant: 5),
            
            servicesLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            servicesLabel.topAnchor.constraint(lessThanOrEqualTo: hodometerTextField.bottomAnchor, constant: 15),
            
            servicesCollectionView.topAnchor.constraint(lessThanOrEqualTo: servicesLabel.bottomAnchor, constant: 5),
            servicesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -38),
            servicesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 38),
            
            pageControl.topAnchor.constraint(equalTo: servicesCollectionView.bottomAnchor),
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            servicesCollectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor),
            
            saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: saveButton.topAnchor)
        ])
    }
}

// MARK: - CollectionView extensions

extension AddMaintenceView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let pages = (allMaintenceItems.count + 1) / 5
        pageControl.numberOfPages = pages
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
        return CGSize(width: 100, height: 110)
    }
}

extension AddMaintenceView: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        scrollView.contentOffset.x = 500
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 1.3

        pageControl.currentPage = Int(offSet) / Int(horizontalCenter)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 1.3
        
        pageControl.currentPage = Int(offSet) / Int(horizontalCenter)

    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        let page = scrollView.contentOffset.x / (scrollView.frame.width - 10 )
//        pageControll.currentPage = Int(page)
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 1.3

        pageControl.currentPage = Int(offSet) / Int(horizontalCenter)
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
