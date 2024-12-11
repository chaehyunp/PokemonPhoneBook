//
//  ViewController.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/9/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let listView = ListView()
    var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        setupNavigationBar()
        setUpListView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let newPhoneBookList = CoreDataManager().readAllData(context: self.container.viewContext)
        listView.updatePhoneBooks(newPhoneBookList)
        
        print(newPhoneBookList)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPhoneBooks()  // 화면이 나타날 때마다 데이터 새로고침
    }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        navigationItem.title = "PhoneBook"
        navigationItem.backButtonTitle = "Back"
        
        let registerButton = UIBarButtonItem(title: "추가",
                                           style: .plain,
                                           target: self,
                                           action: #selector(moveToRegisterView))
        navigationItem.rightBarButtonItem = registerButton
    }
    
    private func loadPhoneBooks() {
        // 이름 기준으로 정렬
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)

    }
    
    @objc
    private func moveToRegisterView() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    private func setUpListView() {
        view.addSubview(listView)
        listView.snp.makeConstraints { view in
            view.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
