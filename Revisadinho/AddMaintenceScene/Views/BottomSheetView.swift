//
//  BottomSheetView.swift
//  Revisadinho
//
//  Created by Jéssica Araujo on 16/09/21.
//
// swiftlint:disable trailing_whitespace line_length

import UIKit

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
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: heightAnchor),
            blurView.widthAnchor.constraint(equalTo: widthAnchor),
            
            bottomSheet.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomSheet.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomSheet.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSheet.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height / 2)
        ])
    }
}
