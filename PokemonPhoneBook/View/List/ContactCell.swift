//
//  ContactCell.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/12/24.
//

import Foundation
import UIKit

class ContactCell: UITableViewCell {
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let phoneLabel = UILabel()
    private let separatorLine = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    private func setupCell() {
        
        // 뷰 추가
        [ profileImageView, nameLabel, phoneLabel, separatorLine ].forEach { view in
            addSubview(view)
        }
        
        // 프로필 이미지
        
        profileImageView.layer.cornerRadius = 30
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.gray.cgColor
        profileImageView.clipsToBounds = true
        
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(60)
        }

        // 이름 레이블
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }

        // 전화번호 레이블
        phoneLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        // 구분선
        separatorLine.backgroundColor = .systemGray3
        
        separatorLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
      
    }
    
    func configure(name: String, phoneNumber: String, profileImage: Data?) {
        nameLabel.text = name
        phoneLabel.text = formatPhoneNumber(phoneNumber)
        if let imageData = profileImage {
            profileImageView.image = UIImage(data: imageData)
        } else {
            profileImageView.image = UIImage.imgNone
        }
    }
}
