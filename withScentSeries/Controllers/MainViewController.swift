//
//  ViewController.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/08/29.
//

import UIKit

final class MainViewController: UIViewController {
    
    
    private var userDataManager = UserDataManager()
    var mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialDatas()
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        configureNavigationBarItem()
        NotificationCenter.default.addObserver(
            self, selector: #selector(updateInformation), name: .infoUpdate, object: nil)
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(addNewInformation), name: .infoCreate, object: nil)
    }
    
    // MARK: - 최초 데이터 작성
    private func setupInitialDatas() {
        userDataManager.makeUserListDatas()
    }
    
    private func configureNavigationBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Icons.addButton,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(showActionSheet))
        navigationController?.hidesBarsOnSwipe = true
    }
    
    // MARK: - 업데이트 노티피케이션 메서드 등록
    @objc func updateInformation(notification: Notification) {
        if let userInfo = notification.userInfo?["updateInfo"] as? CustomUser {
            userDataManager.updateUserInfomation(with: userInfo)
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - 신규 추가 노티피케이션 메서드 등록
    @objc func addNewInformation(notification: Notification) {
        if let userInfo = notification.userInfo?["addNewInfo"] as? CustomUser {
            userDataManager.makeNewUser(userInfo)
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - actionSheet 소환
    @objc func showActionSheet() {
        let alert = UIAlertController(title: "어디에서 검색할까?", message: "검색할 위치를 선택해주세요.",
                                      preferredStyle: .actionSheet)
        
        let fromGallery = UIAlertAction(title: "갤러리에서 가져오기", style: .default) { _ in
            let vc = AddGalleryViewController()
            vc.completion = {
                vc.touchUpImageView()
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let fromWeb = UIAlertAction(title: "웹에서 검색하기", style: .default) { fromWeb in
            let vc = SplashViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .default)
        
        alert.addAction(fromGallery)
        alert.addAction(fromWeb)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userDataManager.getMembersList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell()}
        cell.user = userDataManager[indexPath.row]
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        
        vc.user = self.userDataManager.getMembersList()[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
