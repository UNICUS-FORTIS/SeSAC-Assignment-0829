//
//  ReusableProtocols.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/08/30.
//

import UIKit

protocol reusableViewProtocols {
    static var identifier: String { get }
}

extension UIViewController: reusableViewProtocols {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: reusableViewProtocols{
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: reusableViewProtocols {
    static var identifier: String {
        return String(describing: self)
    }
}

