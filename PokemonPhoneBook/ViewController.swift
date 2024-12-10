//
//  ViewController.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/9/24.
//

import UIKit

class ViewController: UIViewController {
    
    private let listView = ListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        listView.updatePhoneBooks(PhoneBook.sampleData)
        setUpListView()
    }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        navigationItem.title = "PhoneBook"
        
        let registerButton = UIBarButtonItem(title: "추가",
                                             style: .plain,
                                             target: self,
                                             action: #selector(registerNewNumber))
        navigationItem.rightBarButtonItem = registerButton
    }
    
    @objc
    private func registerNewNumber() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    private func setUpListView() {
        view.addSubview(listView)
        
        listView.snp.makeConstraints { view in
            view.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
//#Preview {
//    ViewController()
//}

