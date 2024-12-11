//
//  ListCell.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/10/24.
//

import UIKit
import SnapKit
import Kingfisher

final class ListCell: UITableViewCell {
    
    static let identifier = "ListCell"
    
    // 컨테이너 뷰
    private let container: UIView = {
        let view = UIView()
        return view
    }()
    
    // 포켓몬 이미지뷰
    private let pokemonImg: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    // 이름 레이블
    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // 전화번호 레이블
    private let numberLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // 구분선
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 각 UI 컴포넌트 위치 조정
    private func setUp() {
        
        container.snp.makeConstraints { view in
            view.height.equalTo(60)
        }
    
        // 뷰 부착 및 위치 조정
        contentView.addSubview(container)
        [pokemonImg, nameLabel, numberLabel, separatorLine].forEach { view in
            container.addSubview(view)
        }
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16))
        }
        pokemonImg.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(pokemonImg.snp.trailing).offset(16)
        }
        numberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        separatorLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(6)
            make.height.equalTo(0.5)
        }
    }
    
    func configure(with phoneBook: PhoneBook, isLastCell: Bool) {
        nameLabel.text = phoneBook.name
        numberLabel.text = phoneBook.phoneNumber
        if phoneBook.imagePath != "" {
            pokemonImg.kf.setImage(with: URL(string: phoneBook.imagePath))
        } else {
            pokemonImg.image = UIImage.imgNone
        }
        

        separatorLine.isHidden = isLastCell
    }
}

