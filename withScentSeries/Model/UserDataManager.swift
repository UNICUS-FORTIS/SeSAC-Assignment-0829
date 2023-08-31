//
//  UserData.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/08/30.
//

import UIKit


final class UserDataManager {
    
    private var userList: [CustomUser] = []
    
    func makeUserListDatas() {
        userList = [
            CustomUser(photo: UIImage(named: "sample1") ?? UIImage(), writtenDate: "2023년 5월 1일", title: "페어리필드", description: "오늘은 광휘세팅을 입혀주었다 진짜 예쁘다"),
            
            CustomUser(photo: UIImage(named: "sample2") ?? UIImage(), writtenDate: "2023년 6월 1일", title: "페어리필드", description: "호감도 아바타 입혔는데 생각보다 예쁘다 그런데 염색이 안되서 좀그럼..하지만 존예니까 ㅇㅈ"),
            
            CustomUser(photo: UIImage(named: "sample3") ?? UIImage(), writtenDate: "2023년 4월 3일", title: "페어리필드", description: "엘가시아에서 아바타 새로 산거 티내려구 하트모션 아 짱귀탱"),
            
            CustomUser(photo: UIImage(named: "sample4") ?? UIImage(), writtenDate: "2023년 7월 1일", title: "페어리필드", description: "플로렌스가 입고있던 작년 수영복 염색해서 입혔다 광택넣으니까 SUPER 귀엽다"),
            
            CustomUser(photo: UIImage(named: "sample5") ?? UIImage(), writtenDate: "2023년 7월 2일", title: "페어리필드", description: "모험가  선물로 받은 베레모스타일 모자에다가 검은셔츠로 염색한 트렌디코트룩 우리딸 완존 귀여워 할렐루야!!"),
            
            CustomUser(photo: UIImage(named: "sample6") ?? UIImage(), writtenDate: "2023년 7월 9일", title: "페어리필드", description: "간만에 광휘세트입구 에포나 퀘스트 섬에서 기지개!"),
        ]
    }
    
    
    func getMembersList() -> [CustomUser] {
        return userList
    }
    
    func makeNewUser(_ user: CustomUser) {
        userList.insert(user, at: 0)
    }
    
    func updateUserInfomation(index: Int, with user: CustomUser) {
        userList[index] = user
    }
    
    subscript(index: Int) -> CustomUser {
        get {
            return userList[index]
        }
    }
    
    
}
