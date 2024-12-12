//
//  ListView.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/10/24.
//
import UIKit
import SnapKit

final class ListView: UIView {

    let tableView = UITableView()

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
        
        // 뷰 추가
        addSubview(tableView)
        
        // 테이블 뷰
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
}
