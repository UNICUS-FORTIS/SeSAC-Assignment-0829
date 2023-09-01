
//
//  Unsplash.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/09/01.
//


import Foundation

struct UnsplashData: Codable {
    let total, totalPages: Int
    let results: [UnsplashResult]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct UnsplashResult: Codable {
    let id, slug: String
    let urls: Urls


    enum CodingKeys: String, CodingKey {
        case id, slug
        case urls
    }
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

