//
//  ListCell.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/10/24.
//

import UIKit
import SnapKit

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
        imageView.layer.cornerRadius = 30
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
            view.height.equalTo(80)
        }
    
        // 뷰 부착 및 위치 조정
        contentView.addSubview(container)
        [pokemonImg, nameLabel, numberLabel].forEach { view in
            container.addSubview(view)
        }
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16))
        }
        pokemonImg.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(60)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(pokemonImg.snp.trailing).offset(16)
        }
        numberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func configure(with phoneBook: PhoneBook) {
        nameLabel.text = phoneBook.name
        numberLabel.text = phoneBook.phoneNumber
        // TODO - 이미지 연결
    }
}

