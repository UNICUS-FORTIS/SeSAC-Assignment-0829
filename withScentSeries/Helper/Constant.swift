//
//  Constant.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/08/29.
//

import UIKit

enum Icons {
    static let editButton = UIImage(systemName: "pencil")
    static let addButton = UIImage(systemName: "plus")
    static let checkButton = UIImage(systemName: "checkmark")
    static let xButton = UIImage(systemName: "xmark")

}

enum FontPreset {
    static let title = UIFont.boldSystemFont(ofSize: 25)
    static let writtenDate = UIFont.boldSystemFont(ofSize: 20)
    static let description = UIFont.systemFont(ofSize: 17)
}

enum AlertLiterals {
    static let alert = "어디에서 검색할까?"
    static let alertMeesage = "검색할 위치를 선택해 주세요."
    static let fromGallery = "갤러리에서 가져오기"
    static let fromWeb = "웹에서 검색하기"
    static let cancel = "취소"
}

enum NoticenterUserInfoName {
    static let updateInfo = "updateInfo"
    static let addNewInfo = "addNewInfo"
}
