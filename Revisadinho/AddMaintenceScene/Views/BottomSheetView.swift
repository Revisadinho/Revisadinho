//
//  BottomSheetView.swift
//  Revisadinho
//
//  Created by Jéssica Araujo on 16/09/21.
//
// swiftlint:disable trailing_whitespace

import UIKit
import FSCalendar

class BottomSheetView: UIView {
    
    lazy var bottomSheet: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.backgroundColor = .appBackgroundColor
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
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupBottomSheetView()
        print(UIScreen.main.bounds.size.height / 2)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupBottomSheetView() {
        backgroundColor = .clear
        
        insertSubview(blurView, at: 0)
        addSubview(bottomSheet)
        bottomSheet.addSubview(fsCalendar)
        bottomSheet.addSubview(selectButton)
        
        setupFSCalendar()
        setConstraints()
    }
    
    private func setupFSCalendar() {
        setFSCalendarDelegates()
        
        fsCalendar.appearance.headerTitleFont = UIFont(name: Fonts.semiBold, size: Fonts.sizeForSubtitles)
        fsCalendar.appearance.weekdayFont = UIFont(name: Fonts.semiBold, size: Fonts.sizeForWeekdayCalendar)
        fsCalendar.appearance.titleFont = UIFont(name: Fonts.regular, size: Fonts.sizeForBody)
        
        fsCalendar.backgroundColor = .clear
        fsCalendar.appearance.headerTitleColor = .mainColor
        fsCalendar.appearance.weekdayTextColor = .secondColor
        fsCalendar.appearance.selectionColor = .actionColor
        fsCalendar.appearance.todayColor = .secondColor
        
        fsCalendar.appearance.caseOptions = [.headerUsesCapitalized, .weekdayUsesUpperCase]
        fsCalendar.allowsMultipleSelection = false
        fsCalendar.calendarHeaderView.calendar.locale = Locale(identifier: "pt")
        fsCalendar.appearance.headerMinimumDissolvedAlpha = 0
        fsCalendar.appearance.borderRadius = 2
        fsCalendar.clipsToBounds = true
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
            
            selectButton.centerXAnchor.constraint(equalTo: bottomSheet.centerXAnchor),
            selectButton.topAnchor.constraint(equalTo: fsCalendar.bottomAnchor, constant: 10)
        ])
    }
}

extension BottomSheetView: FSCalendarDataSource {
    private func setFSCalendarDelegates() {
        fsCalendar.dataSource = self
    }
}
