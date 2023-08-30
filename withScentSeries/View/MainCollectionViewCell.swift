//
//  CollectionViewCell.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/08/30.
//

import UIKit
import SnapKit

class MainCollectionViewCell: UICollectionViewCell {
        
    var user: User? {
        didSet {
            mainImageView.image = user?.photo
        }
    }
    
    var mainImageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        contentView.addSubview(mainImageView)
    }
    
    func setConstraints() {
        mainImageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    func cellConfiguration(with: User) {
        mainImageView.image = with.photo
    }
}
