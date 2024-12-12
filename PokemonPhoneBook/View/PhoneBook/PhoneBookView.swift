//
//  PhoneBookView.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/12/24.
//

import Foundation
import UIKit

class PhoneBookView: UIView {
    let profileImageView = UIImageView()
    let randomImageButton = UIButton(type: .system)
    let nameTextView = UITextView()
    let phoneNumberTextView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white
        
        [ profileImageView, randomImageButton, nameTextView, phoneNumberTextView ].forEach { view in
            addSubview(view)
        }
        
        // 프로필 이미지
        profileImageView.layer.cornerRadius = 50
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.gray.cgColor
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = .white
        profileImageView.image = UIImage.imgNone
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(40)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        // 랜덤 이미지 생성 버튼
        randomImageButton.setTitle("랜덤 이미지 생성", for: .normal)
        randomImageButton.setTitleColor(.gray, for: .normal)
        
        randomImageButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        // 이름 레이블
        nameTextView.layer.borderColor = UIColor.gray.cgColor
        nameTextView.layer.borderWidth = 1.0
        nameTextView.layer.cornerRadius = 8.0
        nameTextView.textContainerInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
        nameTextView.font = UIFont.systemFont(ofSize: 16)
        
        nameTextView.snp.makeConstraints { make in
            make.top.equalTo(randomImageButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        
        // 전화번호 레이블
        phoneNumberTextView.layer.borderColor = UIColor.gray.cgColor
        phoneNumberTextView.layer.borderWidth = 1.0
        phoneNumberTextView.layer.cornerRadius = 8.0
        phoneNumberTextView.textContainerInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
        phoneNumberTextView.font = UIFont.systemFont(ofSize: 16)
        
        phoneNumberTextView.snp.makeConstraints { make in
            make.top.equalTo(nameTextView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
    }
    
    func setImage(_ image: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            self?.profileImageView.image = image
        }
    }
}
