//
//  SplashViewController.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/09/01.
//

import UIKit

class SplashViewController: UIViewController {
    
    
    var resultArray:[UnsplashResult] = []
    let networkManager = NetworkManager.shared
    
    
    private let splashView = SplashView()
    
    override func loadView() {
        self.view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splashView.collectionView.dataSource = self
        splashView.searchBar.delegate = self
    }
    
    
}

extension SplashViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell()}
        
        cell.splashData = resultArray[indexPath.item]
        
        return cell
    }
}

//extension SplashViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        let vc = DetailViewController()
//
//        vc.user = self.userDataManager.getMembersList()[indexPath.row]
//
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}

extension SplashViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.resultArray.removeAll(keepingCapacity: true)
        
        if let searchText = splashView.searchBar.text {
            networkManager.requestData(query: searchText) { [weak self] result in
                switch result {
                case .success(let photo):
                    self?.resultArray.append(contentsOf: photo.results)
                    DispatchQueue.main.async {
                        self?.splashView.collectionView.reloadData()
                    }
                    
                case .failure(let error):
                    switch error {
                    case .dataError:
                        print("데이터 에러")
                    case .networkingError:
                        print("네트워킹 에러")
                    case .parseError:
                        print("파싱 에러")
                    }
                }
            }
        }
        
    }
}
