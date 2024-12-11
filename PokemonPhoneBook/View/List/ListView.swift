//
//  ListView.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/10/24.
//
import UIKit
import SnapKit

final class ListView: UIView {
    
    // 데이터
    private var phoneBooks: [PhoneBook] = []
    
    func updatePhoneBooks(_ newPhoneBooks: [PhoneBook]?) {
        if newPhoneBooks == nil { return }
        self.phoneBooks = newPhoneBooks!
        tableView.reloadData()
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
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
        addSubview(tableView)
        tableView.snp.makeConstraints { view in
            view.top.bottom.leading.trailing.equalToSuperview()
        }
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// 데이터 설정
extension ListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phoneBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        let phoneBook = phoneBooks[indexPath.row]
        let isLastCell = indexPath.row == phoneBooks.count - 1
        cell.configure(with: phoneBook, isLastCell: isLastCell)
        return cell
    }
}
