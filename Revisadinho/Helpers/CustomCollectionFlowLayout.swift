//
//  CollectionFlowLayout.swift
//  Revisadinho
//
//  Created by Leonardo Gomes Fernandes on 18/11/21.
// swiftlint:disable trailing_whitespace

import Foundation
import UIKit

class CustomCollectionFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        
        scrollDirection = .horizontal
        minimumLineSpacing = 5
        minimumInteritemSpacing = 0
        sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
