//
//  SplashView.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/09/01.
//

import UIKit


final class SplashView:BaseView {
    
    let searchBar = {
        let bar = UISearchBar()
        bar.placeholder = "검색어를 입력하세요."
        bar.tintColor = .black
        bar.showsCancelButton = true
        bar.autocapitalizationType = .none
        bar.autocorrectionType = .no
        return bar
    }()
    
    lazy var collectionView = {
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: UICollectionView.setCollectionViewLayout(scrollAxis: .vertical, numberOfaxis: 5, numberOfCrossAxis: 2, spacing: 8))
        cv.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCollectionViewCell")
        
        return cv
    }()
    
    
    override func configureView() {
        addSubview(searchBar)
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
}
