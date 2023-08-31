//
//  URL+Extension.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/09/01.
//

import Foundation

extension URL {
    
    static func requestURL(page: Int, lang: String, query: String) -> URL? {
        let urlString = "https://api.unsplash.com/search/photos?query=\(query)&client_id=\(APIKey.accessKey)"
        return URL(string: urlString)
    }
    
}
