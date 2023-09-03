//
//  MainView.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/08/29.
//

import UIKit

class MainView: BaseView {

    lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(MainCollectionViewCell.self,
                      forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    
    
    override func configureView() {
        self.backgroundColor = .white
        self.addSubview(collectionView)
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        lazy var layout = UICollectionView.setCollectionCustomLayout(itemWidthRatio: 1, itemHeightRatio: 0.4, minimumSpacing: 8, scrollDirection: .vertical)
        return layout
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}




