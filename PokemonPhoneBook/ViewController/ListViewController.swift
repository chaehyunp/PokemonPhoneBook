//
//  ListViewController.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/12/24.
//

import Foundation
import UIKit
import CoreData

class ListViewController: UIViewController {
    
    let listView = ListView()
    let coreDataRepository: CoreDataRepository
    
    init(coreDataRepository: CoreDataRepository) {
        self.coreDataRepository = coreDataRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = listView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        fetchContacts()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    private func setupTableView() {
        listView.tableView.dataSource = self
        listView.tableView.delegate = self
        listView.tableView.register(ContactCell.self, forCellReuseIdentifier: "cell")
        listView.tableView.rowHeight = 80
    }
    
    private func fetchContacts() {
        coreDataRepository.fetch()
        listView.tableView.reloadData()
    }
}

// 데이터 처리
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataRepository.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactCell
        let contact = coreDataRepository.contacts[indexPath.row]
        cell.configure(name: contact.name  ?? "", phoneNumber: contact.phoneNumber ?? "", profileImage: contact.profileImage)
        return cell
    }
    
    // 셀을 선택했을 때의 동작
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = coreDataRepository.contacts[indexPath.row]
        let phoneBookViewController = PhoneBookViewController(coreDataRepository: coreDataRepository, mode: .edit(contact))
        navigationController?.pushViewController(phoneBookViewController, animated: true)
    }
}
