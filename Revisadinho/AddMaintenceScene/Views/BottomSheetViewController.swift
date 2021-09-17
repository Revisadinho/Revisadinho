//
//  BottomSheetViewController.swift
//  Revisadinho
//
//  Created by Jéssica Araujo on 16/09/21.
//
// swiftlint:disable trailing_whitespace line_length

import UIKit

class BottomSheetViewController: UIViewController {
    let contentView = BottomSheetView()
    var textField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideBottomSheetView()
    }
    
    override func loadView() {
        view = contentView
    }
    
    func hideBottomSheetView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissBottomSheetView))
        tapGesture.cancelsTouchesInView = false
        contentView.blurView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func dismissBottomSheetView() {
        dismiss(animated: true, completion: nil)
        if textField != nil {
            textField?.endEditing(true)
        }
        
    }
}
