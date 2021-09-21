//
//  ModalViewController.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 21/09/21.
// swiftlint:disable trailing_whitespace line_length

import Foundation
import UIKit

class ModalViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        let modalView = ModalView()
        modalView.collectionView.delegate = self
        modalView.collectionView.dataSource = self
        modalView.controller = self
        view = modalView
    }
}

extension ModalViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        64
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MaintenanceCollectionViewCell.identifier, for: indexPath) as? MaintenanceCollectionViewCell
            
            return cell ?? MaintenanceCollectionViewCell()
    }
    
}
