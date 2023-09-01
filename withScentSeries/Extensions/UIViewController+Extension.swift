//
//  UIViewController+Extension.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/09/02.
//

import UIKit

extension UIViewController {
    
    static func makingDate(with date: Date) -> String {
        let dateFormatter = DateFormatter()
        let locatTime = TimeZone.current
        dateFormatter.timeZone = locatTime
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
}
