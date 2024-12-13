//
//  PhoneBookViewController.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/12/24.
//

import Foundation
import UIKit

enum PhoneBookMode {
    case write
    case edit(Contact)
}

class PhoneBookViewController: UIViewController {
    
    let phoneBookView = PhoneBookView()
    let imageRepository = ImageRepository()
    let coreDataRepository: CoreDataRepository
    let mode: PhoneBookMode
    
    init(coreDataRepository: CoreDataRepository, mode: PhoneBookMode) {
        self.coreDataRepository = coreDataRepository
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = phoneBookView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupAction()
        configureViewForMode()
    }
    
    private func configureViewForMode() {
        switch mode {
        case .write:
            navigationController?.title = "연락처 추가"
        case .edit(let contact):
            navigationController?.title = contact.name
            phoneBookView.nameTextView.text = contact.name
            phoneBookView.phoneNumberTextView.text = contact.phoneNumber
            if let imageData = contact.profileImage {
                phoneBookView.setImage(UIImage(data: imageData))
            } else {
                phoneBookView.setImage(UIImage.imgNone)
            }
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용", style: .done, target: self, action: #selector(applyChanges))
    }
    
    private func setupAction() {
        phoneBookView.randomImageButton.addTarget(self, action: #selector(generateRandomImage), for: .touchUpInside)
    }
    
    @objc private func generateRandomImage() {
        imageRepository.fetchRandomPokemonImage { [weak self] image in
            guard let self = self else { return }
            self.phoneBookView.setImage(image)
        }
    }
    
    @objc private func applyChanges() {
        
        // name과 phoneNumber의 텍스트 placeholder 체크
        let name = (phoneBookView.nameTextView.text == phoneBookView.namePlaceholder 
                    || phoneBookView.nameTextView.text?.isEmpty == true) ?
                    "" : phoneBookView.nameTextView.text ?? ""
        
        let phoneNumber = (phoneBookView.phoneNumberTextView.text == phoneBookView.phoneNumberPlaceholder
                           || phoneBookView.phoneNumberTextView.text?.isEmpty == true) ?
                           "" : phoneBookView.phoneNumberTextView.text ?? ""

        // 유효성 검사 - 값 유무 및 프로필 이미지 존재 여부 체크
        guard !name.isEmpty, !phoneNumber.isEmpty, let profileImage = phoneBookView.profileImageView.image else {
            showOneButtonAlert(title: "저장 오류", message: "모든 항목을 입력해주세요.")
            return
        }

        
        // 모드에 따라 변경사항 저장 방법 분기
        switch mode {
        case .write:
            let contact = Contact(context: coreDataRepository.context)
            contact.name = name
            contact.phoneNumber = phoneNumber
            contact.profileImage = profileImage.pngData()
            
        case .edit(let contact):
            contact.name = name
            contact.phoneNumber = phoneNumber
            contact.profileImage = profileImage.pngData()
        }
        
        coreDataRepository.saveContext()
        
        navigationController?.popViewController(animated: true)
    }
    
    private func showOneButtonAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
