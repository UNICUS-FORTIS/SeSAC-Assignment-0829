//
//  AddViewController.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/08/29.
//

import UIKit
import PhotosUI

class EditViewController: UIViewController {
    
    let editView = EditView()
    var user: User?
    
    override func loadView() {
        super.loadView()
        self.view = editView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSetsup()
        configureNavigationBar()
        configureGestures()
    }
    
    private func dataSetsup() {
        self.editView.user = user
    }

    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Icons.checkButton,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(checkButtonTapped))
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    // MARK: - 옵저버 실행
    @objc private func checkButtonTapped() {
        
        self.user?.id = editView.user?.id ?? 0
        self.user?.photo = editView.mainImageView.image ?? UIImage()
        self.user?.title = editView.titleLabel.text ?? ""
        self.user?.description = editView.descriptionLabel.text
        self.editView.user = user
        
        let userInfo: [String: Any] = ["updateInfo": user!]
        NotificationCenter.default.post(name: .updateImage, object: nil, userInfo: userInfo)
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 제스처 등록
    func configureGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpImageView))
        editView.mainImageView.addGestureRecognizer(tapGesture)
        editView.mainImageView.isUserInteractionEnabled = true
    }
    
    @objc func touchUpImageView() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        // 피커뷰 띄우기
        self.present(picker, animated: true, completion: nil)
    }
}

// MARK: - PHPicker등록
extension EditViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results:
                [PHPickerResult]) {
        
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    self.editView.mainImageView.image = image as? UIImage
                    self.user?.photo = image as? UIImage ?? UIImage()
                }
            }
        } else {
            print("에러발생")
        }
    }
}
