//
//  ViewController.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/9/24.
//

import UIKit

final class RegisterViewController: UIViewController {
    
    private let registerView = RegisterView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRegisterView()
    }
    
    private func setUpRegisterView() {
        view.addSubview(registerView)
        
        registerView.snp.makeConstraints { view in
            view.top.bottom.leading.trailing.equalToSuperview()
        }
    }
  
}
//#Preview {
//    ViewController()
//}

