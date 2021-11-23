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
        minimumLineSpacing = 20
        minimumInteritemSpacing = 15
        sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func targetContentOffset(
//        forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//            guard let collectionView = collectionView else { return proposedContentOffset }
//            let pageWidth = itemSize.width + minimumLineSpacing
//            let currentPage: CGFloat = collectionView.contentOffset.x / pageWidth
//            let nearestPage: CGFloat = round(currentPage)
//            let isNearPreviousPage = nearestPage < currentPage
//            var pageDiff: CGFloat = 0
//            let velocityThreshold: CGFloat = 0.5
//            if isNearPreviousPage {
//                if velocity.x > velocityThreshold {
//                    pageDiff = 1
//                }
//            } else {
//                if velocity.x < -velocityThreshold {
//                    pageDiff = -1
//                }
//            }
//            let x = (nearestPage + pageDiff) * pageWidth
//            let cappedX = max(0, x)
//            return CGPoint(x: cappedX, y: proposedContentOffset.y)
//        }
    
}
