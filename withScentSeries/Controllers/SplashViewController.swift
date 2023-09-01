//
//  SplashViewController.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/09/01.
//

import UIKit

final class SplashViewController: UIViewController {
    
    
    private var resultArray:[UnsplashResult] = []
    private let networkManager = NetworkManager.shared
    private var currentPage: Int = 1
    
    private let splashView = SplashView()
    
    override func loadView() {
        self.view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splashView.collectionView.dataSource = self
        splashView.collectionView.prefetchDataSource = self
        splashView.searchBar.delegate = self
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
}

// MARK: - Extension CV Datasource
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
// MARK: - Extension CV DataSource Prefetching
extension SplashViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            print(resultArray.count-1, indexPath.item , currentPage)
            guard let searchText = splashView.searchBar.text else { return }
            if resultArray.count-1 == indexPath.item && currentPage < 10 {
                self.currentPage += 1
                networkManager.requestData(query: searchText, page: currentPage)  { [weak self] result in
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
// MARK: - Extension SearchBar Delegate
extension SplashViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = splashView.searchBar.text else { return }
        self.currentPage = 1
        self.resultArray.removeAll(keepingCapacity: true)
        networkManager.requestData(query: searchText, page: currentPage) { [weak self] result in
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.splashView.searchBar.text = ""
        self.currentPage = 1
        self.resultArray.removeAll()
        DispatchQueue.main.async {
            self.splashView.collectionView.reloadData()
        }
    }
}
