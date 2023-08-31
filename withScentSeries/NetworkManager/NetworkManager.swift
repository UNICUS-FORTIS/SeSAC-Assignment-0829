//
//  NetworkManager.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/09/01.
//

import Foundation

enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func requestData(query: String, completion: @escaping (Result<UnsplashData, NetworkError>) -> Void) {
        
        let apiKey = APIKey.accessKey
        let url = URL.requestURL(page: 1, lang: "ko", query: "Moon")!
        var request = URLRequest(url: url)
        
        request.addValue(Headers.HeaderValue, forHTTPHeaderField: Headers.HeaderName)
                
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            do {
                
                let decoder = JSONDecoder()
                let searchResult = try decoder.decode(UnsplashData.self, from: safeData)
                completion(.success(searchResult))
                
            } catch {
                
                completion(.failure(.parseError))
                
            }
        }.resume()
    }
}

