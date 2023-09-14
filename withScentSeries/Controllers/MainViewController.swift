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
        
        mainView.registerCell()
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
        if let userInfo = notification.userInfo?[NoticenterUserInfoName.updateInfo] as? CustomUser {
            userDataManager.updateUserInfomation(with: userInfo)
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - 신규 추가 노티피케이션 메서드 등록
    @objc func addNewInformation(notification: Notification) {
        if let userInfo = notification.userInfo?[NoticenterUserInfoName.addNewInfo] as? CustomUser {
            userDataManager.makeNewUser(userInfo)
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - actionSheet 소환
    @objc func showActionSheet() {
        let alert = UIAlertController(title: AlertLiterals.alert, message: AlertLiterals.alertMeesage,
                                      preferredStyle: .actionSheet)
        
        let fromGallery = UIAlertAction(title: AlertLiterals.fromGallery, style: .default) { _ in
            let vc = AddGalleryViewController()
            vc.completion = {
                vc.touchUpImageView()
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let fromWeb = UIAlertAction(title: AlertLiterals.fromWeb, style: .default) { fromWeb in
            let vc = SplashViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let cancel = UIAlertAction(title: AlertLiterals.cancel, style: .default)
        
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
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell()}
//        cell.user = userDataManager[indexPath.item]
        
        let data = userDataManager[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: mainView.cellRegistration,
                                                                for: indexPath,
                                                                item: data)
        
        return cell
    }
}
// MARK: - Declare CollectionView Delegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        
        vc.user = self.userDataManager.getMembersList()[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Declare CollectionView Flowlayout
//extension MainViewController: UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let screenWidth = UIScreen.main.bounds.width
//        
//        let target = userDataManager[indexPath.item]
//        let width = target.photo.size.width
//        let height = target.photo.size.height
//        let widthRatio = width / height
//        let itemWidth = screenWidth
//        let itemHeight = screenWidth / widthRatio
//        
//        return CGSize(width: itemWidth, height: itemHeight)
//        
//    }
//}
