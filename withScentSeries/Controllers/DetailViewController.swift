//
//  DetailViewController.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/08/30.
//

import UIKit

final class DetailViewController: UIViewController {
    
    let detailView = DetailView()
    var user: CustomUser?
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupData()
        // MARK: - 옵저버 등록
        NotificationCenter.default.addObserver(self, selector: #selector(updateInformation), name: .infoUpdate, object: nil)
    }
    
    private func setupData() {
        self.detailView.user = user
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Icons.editButton,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(editButtonTapped))
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
    }
    
    @objc func updateInformation(notification: Notification) {
        if let userInfo = notification.userInfo?["updateInfo"] as? CustomUser {
            self.user = userInfo
            self.detailView.user = userInfo
        }
    }
    
    @objc private func editButtonTapped() {
        let vc = EditViewController()
        guard let user = user else { return }
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .infoUpdate, object: nil)
        NotificationCenter.default.removeObserver(self, name: .infoCreate, object: nil)
    }
}

