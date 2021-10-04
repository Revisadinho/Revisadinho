//
//  BottomSheetView.swift
//  Revisadinho
//
//  Created by Jéssica Araujo on 16/09/21.
//
// swiftlint:disable trailing_whitespace
// swiftlint:disable line_length

import UIKit
import FSCalendar

class BottomSheetView: UIView {
    
    lazy var bottomSheet: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.backgroundColor = .monthCardBackground
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.frame = frame
        blurEffectView.alpha = 0.6
        return blurEffectView
    }()
    
    lazy var fsCalendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    lazy var selectButton: CustomButton = {
        let button = CustomButton()
        button.setTitle(AddMaintenceViewStrings.bottomSheetButtonLabel, for: .normal)
        button.tintColor = .buttonLabelText
        return button
    }()
    
    lazy var nextMonthButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .purpleAction
        return button
    }()
    
    lazy var previousMonthButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .purpleAction
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupBottomSheetView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupBottomSheetView() {
        backgroundColor = .clear
        
        insertSubview(blurView, at: 0)
        addSubview(bottomSheet)
        bottomSheet.addSubview(fsCalendar)
        bottomSheet.addSubview(nextMonthButton)
        bottomSheet.addSubview(previousMonthButton)
        bottomSheet.addSubview(selectButton)
        
        setupFSCalendar()
        setupButtons()
        setConstraints()
    }
    
    private func setupFSCalendar() {
        setFSCalendarDelegates()
        
        fsCalendar.appearance.headerTitleFont = UIFont(name: Fonts.semiBold, size: Fonts.sizeForSubtitles)
        fsCalendar.appearance.weekdayFont = UIFont(name: Fonts.semiBold, size: Fonts.sizeForWeekdayCalendar)
        fsCalendar.appearance.titleFont = UIFont(name: Fonts.regular, size: Fonts.sizeForBody)
        
        fsCalendar.backgroundColor = .clear
        fsCalendar.appearance.headerTitleColor = .grayText
        fsCalendar.appearance.weekdayTextColor = .purpleDayNameCalendar
        fsCalendar.appearance.selectionColor = .purpleAction
        fsCalendar.appearance.todayColor = .selecCalendar
        fsCalendar.appearance.titleDefaultColor = .calenderDaysColor
        fsCalendar.appearance.titleSelectionColor = .buttonLabelText
        fsCalendar.appearance.titlePlaceholderColor = .calenderDaysOutColor

        fsCalendar.appearance.headerTitleAlignment = .left
        fsCalendar.appearance.headerTitleOffset = CGPoint(x: bottomSheet.bounds.size.width - 78, y: 0)
        
        fsCalendar.appearance.caseOptions = [.headerUsesCapitalized, .weekdayUsesUpperCase]
        fsCalendar.allowsMultipleSelection = false
        fsCalendar.calendarHeaderView.calendar.locale = Locale(identifier: "pt")
        fsCalendar.appearance.headerMinimumDissolvedAlpha = 0
        fsCalendar.appearance.borderRadius = 2
        fsCalendar.clipsToBounds = true
    }
    
    private func setupButtons() {
        let largeConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .medium)
        let chevronForwardImage = UIImage(systemName: AddMaintenceViewStrings.chevronForwardIcon, withConfiguration: largeConfiguration)
        let chevronBackwardImage = UIImage(systemName: AddMaintenceViewStrings.chevronBackwardIcon, withConfiguration: largeConfiguration)
        
        nextMonthButton.setImage(chevronForwardImage, for: .normal)
        previousMonthButton.setImage(chevronBackwardImage, for: .normal)
        
        nextMonthButton.addTarget(self, action: #selector(onNextMonthButtonClick), for: .touchUpInside)
        previousMonthButton.addTarget(self, action: #selector(onPreviouMonthButtonClick), for: .touchUpInside)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: heightAnchor),
            blurView.widthAnchor.constraint(equalTo: widthAnchor),
            
            bottomSheet.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomSheet.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomSheet.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSheet.heightAnchor.constraint(equalToConstant: 400),
            
            fsCalendar.heightAnchor.constraint(equalToConstant: 312),
            fsCalendar.widthAnchor.constraint(equalToConstant: 346),
            fsCalendar.centerXAnchor.constraint(equalTo: bottomSheet.centerXAnchor),
            fsCalendar.topAnchor.constraint(equalTo: bottomSheet.topAnchor, constant: 10),
            
            nextMonthButton.heightAnchor.constraint(equalToConstant: 30),
            nextMonthButton.widthAnchor.constraint(equalToConstant: 25),
            nextMonthButton.topAnchor.constraint(equalTo: bottomSheet.topAnchor, constant: 20),
            nextMonthButton.trailingAnchor.constraint(equalTo: bottomSheet.trailingAnchor, constant: -15),
            
            previousMonthButton.heightAnchor.constraint(equalToConstant: 30),
            previousMonthButton.widthAnchor.constraint(equalToConstant: 25),
            previousMonthButton.topAnchor.constraint(equalTo: bottomSheet.topAnchor, constant: 20),
            previousMonthButton.trailingAnchor.constraint(equalTo: nextMonthButton.leadingAnchor, constant: -30),
            
            selectButton.centerXAnchor.constraint(equalTo: bottomSheet.centerXAnchor),
            selectButton.topAnchor.constraint(equalTo: fsCalendar.bottomAnchor, constant: 10)
        ])
    }
    
    @objc
    func onPreviouMonthButtonClick() {
        fsCalendar.setCurrentPage(getPreviousMonth(date: fsCalendar.currentPage), animated: true)
    }
    
    @objc
    func onNextMonthButtonClick() {
        fsCalendar.setCurrentPage(getNextMonth(date: fsCalendar.currentPage), animated: true)
    }
    
    private func getNextMonth(date: Date) -> Date {
        return Calendar.current.date(byAdding: .month, value: 1, to: date)!
    }
    
    private func getPreviousMonth(date: Date) -> Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: date)!
    }
}

extension BottomSheetView: FSCalendarDataSource {
    private func setFSCalendarDelegates() {
        fsCalendar.dataSource = self
    }
}
