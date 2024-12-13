//
//  PhoneBookView.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/12/24.
//

import Foundation
import UIKit

class PhoneBookView: UIView {
    
    let namePlaceholder = "이름을 입력하세요"
    let phoneNumberPlaceholder = "전화번호를 입력하세요"
    let maxPhoneNumberLength = 11
    
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
        
        nameTextView.delegate = self
        phoneNumberTextView.delegate = self
        
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
        nameTextView.text = namePlaceholder
        nameTextView.textColor = .lightGray
        
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
        phoneNumberTextView.text = phoneNumberPlaceholder
        phoneNumberTextView.textColor = .lightGray
        
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

// MARK: - UITextViewDelegate
extension PhoneBookView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let placeholder = (textView == nameTextView) ? namePlaceholder : phoneNumberPlaceholder
        
        if textView.text == placeholder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = if textView == nameTextView { namePlaceholder } else { phoneNumberPlaceholder }
            textView.textColor = .lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if textView == phoneNumberTextView {
            let currentText = textView.text ?? ""
            let finalText = (currentText == phoneNumberPlaceholder) ? "" : currentText
            
            guard let stringRange = Range(range, in: finalText) else { return false }
            let updatedText = finalText.replacingCharacters(in: stringRange, with: text)
            
            let numberRegex = "^[0-9]*$"
            let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
            
            if textView.text != phoneNumberPlaceholder && updatedText.count > maxPhoneNumberLength {
                return false
            }
            
            return numberPredicate.evaluate(with: updatedText)
        }
        
        return true
    }
}
