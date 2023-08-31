//
//  AddNewViewController.swift
//  withScentSeries
//
//  Created by LOUIE MAC on 2023/08/31.
//

import UIKit
import PhotosUI

class AddGalleryViewController: UIViewController {
    
    
    private let editView = EditView()
    var user: CustomUser?
    
    override func loadView() {
        self.view = editView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultInformation()
        configureNavigationBarItem()
        touchUpImageView()
    }
    
    private func configureNavigationBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .checkmark,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(doneButtonTapped))
    }
    
    @objc func doneButtonTapped() {
        let photo = editView.mainImageView.image ?? UIImage()
        let title = editView.titleLabel.text ?? ""
        let date = editView.writtenDate.text ?? ""
        let description = editView.descriptionLabel.text ?? ""
        let newData = CustomUser(photo: photo, writtenDate: date, title: title, description: description)
        
        let userInfo: [String: Any] = ["addNewInfo": newData]
        NotificationCenter.default.post(name: .infoCreate, object: nil, userInfo: userInfo)
        
        navigationController?.popViewController(animated: true)
    }
    
    private func setDefaultInformation() {
            
        let currentDate = Date()
        let formattedDate = self.makingDate(with: currentDate)
    
        let newData = CustomUser(photo: UIImage(), writtenDate: formattedDate, title: "제목", description: "내용을 입력해주세요.")
        print(newData.writtenDate)
        self.editView.user = newData
    }
    
    private func makingDate(with date: Date) -> String {
        let dateFormatter = DateFormatter()
        let locatTime = TimeZone.current
        dateFormatter.timeZone = locatTime
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
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
                }
            }
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}


