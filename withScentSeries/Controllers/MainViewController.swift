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
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let vc = EditViewController.shared
        vc.completionHandler = { user in
            if self.userData.datas[user.id].id == user.id {
                print(self.userData.datas[user.id].id)
                self.userData.datas[user.id].photo = user.photo
                self.mainView.collectionView.reloadData()
            }
        }
        print(#function)

    }
    
    private func configureNavigationBar() {
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Icons.addButton,
//                                                            style: .plain,
//                                                            target: self,
//                                                            action: #selector(addButtonTapped))
        navigationController?.hidesBarsOnSwipe = true
    }
    
//    @objc private func addButtonTapped() {
//        let vc = AddViewController()
//        navigationController?.pushViewController(vc, animated: true)
//    }
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userData.datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell()}
        cell.user = userData.datas[indexPath.row]
        print(#function)
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

//extension MainViewController: DataTransferProtocol {
//    func updateDatas(with user: User) {
//        userData.datas[user.id].id = user.id
//        userData.datas[user.id].photo = user.photo
//        print(user.photo)
//        print("실행됨")
//        mainView.collectionView.reloadData()
//    }
//}
