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
        
        // placeholder 체크와 빈 문자열 체크를 함께 처리
        let name = phoneBookView.nameTextView.text == phoneBookView.namePlaceholder ? "" : phoneBookView.nameTextView.text ?? ""
        let number = phoneBookView.phoneNumberTextView.text == phoneBookView.phoneNumberPlaceholder ? "" : phoneBookView.phoneNumberTextView.text ?? ""
        
        // 유효성 검사 - 값 유무
        guard !name.isEmpty, !number.isEmpty,
              let profileImage = phoneBookView.profileImageView.image else { return }
        
        
        guard let name = phoneBookView.nameTextView.text, !name.isEmpty,
              let phoneNumber = phoneBookView.phoneNumberTextView.text, !phoneNumber.isEmpty,
              let profileImage = phoneBookView.profileImageView.image else { return }
        
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
    
}
