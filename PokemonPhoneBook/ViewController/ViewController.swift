//
//  ViewController.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/9/24.
//

import UIKit
import CoreData
import SnapKit

class ViewController: UIViewController {
    
    let coreDataRepository = CoreDataRepository(modelName: "PokemonPhoneBook")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = ListViewController(coreDataRepository: coreDataRepository)
        let list = UINavigationController(rootViewController: vc) // 내비게이션 컨트롤러로 감싸주기
        navigationItem.title = "친구 목록"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addContact))
        setup(list)
    }
    
    func setup(_ child: UIViewController) {
        
        addChild(child)
        self.view.addSubview(child.view)
        
        child.view.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        child.didMove(toParent: self)
    }
    
    @objc private func addContact() {
        let phoneBookViewController = PhoneBookViewController(coreDataRepository: coreDataRepository, mode: .write)
        navigationController?.pushViewController(phoneBookViewController, animated: true)
    }
    
}
