//
//  RegistrationView.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/10/24.
//
import UIKit
import SnapKit

final class RegisterView: UIView {
    private let imageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 60
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    private let randomButton: UIButton =  {
        let button = UIButton()
        button.setTitle("랜덤 포켓몬 이미지", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private let nameTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 8
        textView.font = .systemFont(ofSize: 16)
        textView.text = "이름을 입력하세요"
        textView.textColor = .lightGray
        return textView
    }()
    
    private let numberTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 8
        textView.font = .systemFont(ofSize: 16)
        textView.text = "전화번호를 입력하세요"
        textView.textColor = .lightGray
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        setUp()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        [imageView, randomButton, nameTextView, numberTextView].forEach { view in
            self.addSubview(view)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(120)
        }
        randomButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
        nameTextView.snp.makeConstraints { make in
            make.top.equalTo(randomButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        numberTextView.snp.makeConstraints { make in
            make.top.equalTo(nameTextView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    
}
