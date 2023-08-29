//
//  DetailViewController.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/08/30.
//

import UIKit

class DetailViewController: UIViewController {

    let detailView = DetailView()
    var user: User?
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupData()
    }
    
    private func setupData() {
        self.detailView.user = user
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        let vc = EditViewController.shared
//        vc.completionHandler = { user in
//            self.user?.photo = user.photo
//            self.user?.title = user.title
//            self.user?.description = user.description
//            self.setupData()
//        }
//    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Icons.editButton,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(editButtonTapped))
        navigationController?.navigationBar.topItem?.backButtonTitle = ""

    }
    
    var toMaincompletionHandler: ((User)->Void)?

    
    @objc private func editButtonTapped() {
        let vc = EditViewController.shared
//        vc.delegate = self
        guard let user = user else {return}
        vc.user = user
        vc.completionHandler = { user in
            self.user?.photo = user.photo
            self.user?.title = user.title
            self.user?.description = user.description
            self.setupData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

//extension DetailViewController: DataTransferProtocol {
//    func updateDatas(with user: User) {
//        detailView.mainImageView.image = user.photo
//        detailView.titleLabel.text = user.title
//        detailView.descriptionLabel.text = user.description
//    }
//}
