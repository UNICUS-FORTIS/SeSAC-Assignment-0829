//
//  AddNewViewController.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/08/31.
//

import UIKit
import PhotosUI

final class AddGalleryViewController: UIViewController {
    
    
    private let editView = EditView()
    var user: CustomUser?
    
    override func loadView() {
        self.view = editView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultInformation()
        configureNavigationBarItem()
        completion()
    }
    
    private func configureNavigationBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .checkmark,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(doneButtonTapped))
    }
    
    // MARK: - declare completion for MainViewController diversity of action.
    var completion: () -> () = {}

    
    @objc func doneButtonTapped() {
        let currentDate = Date()
        let photo = editView.mainImageView.image ?? UIImage()
        let title = editView.titleLabel.text ?? ""
        let formattedDate = AddGalleryViewController.makingDate(with: currentDate)
        let description = editView.descriptionLabel.text ?? ""
        let newData = CustomUser(photo: photo, writtenDate: formattedDate, title: title, description: description)
        
        let userInfo: [String: Any] = [NoticenterUserInfoName.addNewInfo: newData]
        NotificationCenter.default.post(name: .infoCreate, object: nil, userInfo: userInfo)
        
        navigationController?.popToRootViewController(animated: true)

    }
    
    private func setDefaultInformation() {
        
        let currentDate = Date()
        let formattedDate = AddGalleryViewController.makingDate(with: currentDate)
        if let existUser = self.user {
            self.editView.user = existUser
        } else {
            let newData = CustomUser(photo: UIImage(),
                                     writtenDate: formattedDate,
                                     title: "제목",
                                     description: "내용을 입력해주세요.")
            self.editView.user = newData
        }
    }
    
    // MARK: - 피커뷰 소환
    @objc func touchUpImageView() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
}

// MARK: - PHPicker등록
extension AddGalleryViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results:
                [PHPickerResult]) {
        
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    self.editView.mainImageView.image = image as? UIImage
                    self.user?.photo = image as? UIImage ?? UIImage()
                    self.editView.titleLabel.becomeFirstResponder()
                }
            }
        } else {
            navigationController?.popToRootViewController(animated: true)
        }
    }
}


