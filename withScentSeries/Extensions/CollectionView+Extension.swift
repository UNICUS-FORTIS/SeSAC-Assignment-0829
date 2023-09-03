//
//  CollectionView+Extension.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/08/29.
//

import UIKit

extension UICollectionView {
    static func setCollectionCustomLayout(itemWidthRatio: CGFloat,
                                   itemHeightRatio: CGFloat,
                                   minimumSpacing: CGFloat,
                                   scrollDirection: UICollectionView.ScrollDirection)
    -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = minimumSpacing
        layout.minimumInteritemSpacing = minimumSpacing
        layout.sectionInset = UIEdgeInsets(top: minimumSpacing, left: 0, bottom: minimumSpacing, right: 0)
        layout.scrollDirection = scrollDirection
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
                
        if scrollDirection == .vertical {
            let itemWidth = screenWidth * itemWidthRatio
            let itemHeight = screenHeight * itemHeightRatio
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        } else {
            let itemWidth = screenHeight * itemWidthRatio
            let itemHeight = screenWidth * itemHeightRatio
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        }
        return layout
    }
}
