//
//  CollectionView+Extension.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/08/29.
//

import UIKit

extension UICollectionView {
    
    static func setCollectionViewLayout(
        scrollAxis: UICollectionView.ScrollDirection,
        numberOfaxis: Int,
        numberOfCrossAxis: Int,
        spacing: CGFloat
        ) -> UICollectionViewFlowLayout{
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = scrollAxis
        let width = UIScreen.main.bounds.width - ( spacing * CGFloat(numberOfCrossAxis) )
        let height = UIScreen.main.bounds.height - ( spacing * CGFloat(numberOfaxis) )
        layout.itemSize = CGSize(width: width/CGFloat(numberOfCrossAxis), height: height/CGFloat(numberOfaxis))
        layout.sectionInset = UIEdgeInsets(
            top: spacing,
            left: 0,
            bottom: spacing,
            right: 0)
        
        return layout
    }
}
