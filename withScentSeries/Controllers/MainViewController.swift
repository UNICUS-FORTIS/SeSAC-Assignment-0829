//
//  ViewController.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/08/29.
//

import UIKit
import PhotosUI

class MainViewController: UIViewController {
    
    var userData = UserData()
    var mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
//        configureNavigationBar()
        NotificationCenter.default.addObserver(
            self, selector: #selector(updateInformation), name: .updateImage, object: nil)
    }
    
//    private func configureNavigationBar() {
//        //        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Icons.addButton,
//        //                                                            style: .plain,
//        //                                                            target: self,
//        //                                                            action: #selector(addButtonTapped))
//        navigationController?.hidesBarsOnSwipe = true
//    }
    
    @objc func updateInformation(notification: Notification) {
        if let userInfo = notification.userInfo?["updateInfo"] as? User {
            userData.updateMemberInfo(index: userInfo.id, userInfo)
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userData.datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell()}
        cell.user = userData.datas[indexPath.row]
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        
        DispatchQueue.main.async {
            vc.user = self.userData.datas[indexPath.row]
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
