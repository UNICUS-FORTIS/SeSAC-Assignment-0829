//
//  UserData.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/08/29.
//

import UIKit


struct CustomUser {
    
    static var userId: Int = 0

    let id: Int
    var photo: UIImage
    let writtenDate: String
    var title: String
    var description: String
    
    init(photo: UIImage, writtenDate: String, title: String, description: String) {
        self.id = CustomUser.userId
        
        self.photo = photo
        self.writtenDate = writtenDate
        self.title = title
        self.description = description
        
        CustomUser.userId += 1
    }
}
