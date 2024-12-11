//
//  RegistrationView.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/10/24.
//
import UIKit
import SnapKit
import Kingfisher

final class RegisterView: UIView {
    
    private let namePlaceholder = "이름을 입력하세요"
    private let numberPlaceholder = "전화번호를 입력하세요"
    private let maxPhoneNumberLength = 11
    private var randomPokemonImgPath = ""
    
    let imageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 60
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1
        imageView.image = UIImage(named: "ImgNone")
        return imageView
    }()
    
    private let randomButton: UIButton =  {
        let button = UIButton()
        button.setTitle("랜덤 포켓몬 이미지", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(getRandomPokemonImg), for: .touchUpInside)
        return button
    }()
    
    private let nameTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 8
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = .lightGray
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        textView.textContainer.lineFragmentPadding = 0
        return textView
    }()
    
    private let numberTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 8
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = .lightGray
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        textView.textContainer.lineFragmentPadding = 0
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        setUp()
        setUpTextViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        [imageView, randomButton, nameTextView, numberTextView].forEach { view in
            self.addSubview(view)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(160)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(120)
        }
        randomButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
        nameTextView.snp.makeConstraints { make in
            make.top.equalTo(randomButton.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        numberTextView.snp.makeConstraints { make in
            make.top.equalTo(nameTextView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    private func setUpTextViews() {
        nameTextView.delegate = self
        numberTextView.delegate = self
        nameTextView.text = namePlaceholder
        numberTextView.text = numberPlaceholder
    }
    
    @objc
    private func getRandomPokemonImg() {

        let url = APIManager().getPokemonImageUrl()
        imageView.kf.setImage(with: url)
        randomPokemonImgPath = URLStringUtils.getURLString(from: url)
    }
}

// MARK: - UITextViewDelegate
extension RegisterView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let placeholder = (textView == nameTextView) ? namePlaceholder : numberPlaceholder
        
        if textView.text == placeholder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = if textView == nameTextView { namePlaceholder } else { numberPlaceholder }
            textView.textColor = .lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if textView == numberTextView {
            let currentText = textView.text ?? ""
            let finalText = (currentText == numberPlaceholder) ? "" : currentText
            
            guard let stringRange = Range(range, in: finalText) else { return false }
            let updatedText = finalText.replacingCharacters(in: stringRange, with: text)
            
            let numberRegex = "^[0-9]*$"
            let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
            
            if textView.text != numberPlaceholder && updatedText.count > maxPhoneNumberLength {
                return false
            }
            
            return numberPredicate.evaluate(with: updatedText)
        }
        
        return true
    }
}


extension RegisterView {
    func getInputData() -> PhoneBook {
        let name = nameTextView.text == namePlaceholder ? "" : nameTextView.text ?? ""
        let number = numberTextView.text == numberPlaceholder ? "" : numberTextView.text ?? ""
        let imagePath = randomPokemonImgPath
        return PhoneBook(name: name, phoneNumber: number, imagePath: imagePath)
    }
}

