//
//  MainView.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/08/29.
//

import UIKit

class MainView: BaseView {
    
    lazy var collectionView = {
        let cv = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionView.setCollectionViewLayout(
                scrollAxis: .vertical,
                numberOfaxis: 3,
                numberOfCrossAxis: 1,
                spacing: 0))
        cv.register(MainCollectionViewCell.self,
                    forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    override func configureView() {
        self.backgroundColor = .white
        self.addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}




