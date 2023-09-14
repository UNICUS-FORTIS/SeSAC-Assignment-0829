//
//  MainView.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/08/29.
//

import UIKit

class MainView: BaseView {

//    lazy var collectionView = {
//        var layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        view.register(MainCollectionViewCell.self,
//                      forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
//        layout = self.collectionViewLayout()
//        view.showsVerticalScrollIndicator = false
//        return view
//    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setLayout())
    
    var cellRegistration: UICollectionView.CellRegistration<MainCollectionViewCell, CustomUser>!
    
    
    override func configureView() {
        self.backgroundColor = .white
        self.addSubview(collectionView)
    }
    
//    private func collectionViewLayout() -> UICollectionViewFlowLayout {
//        lazy var layout = UICollectionView.setCollectionCustomLayout(itemWidthRatio: 1, itemHeightRatio: 0.4, minimumSpacing: 8, scrollDirection: .vertical)
//        return layout
//    }
    
    static func setLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(0.3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func registerCell() {
        cellRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.cell()
            content.image = itemIdentifier.photo
            cell.contentConfiguration = content
        })
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}




