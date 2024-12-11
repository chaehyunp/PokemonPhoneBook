//
//  ViewController.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/9/24.
//

import UIKit
import CoreData

final class RegisterViewController: UIViewController {
    
    private let registerView = RegisterView()
    var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        setupNavigationBar()
        setUpRegisterView()
    }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        navigationItem.title = "연락처 추가"
        
        let saveButton = UIBarButtonItem(title: "적용",
                                         style: .plain,
                                         target: self,
                                         action: #selector(saveNewNumber))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func setUpRegisterView() {
        view.addSubview(registerView)
        
        registerView.snp.makeConstraints { view in
            view.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    @objc
    private func saveNewNumber() {
        let inputData = registerView.getInputData()
        
        // 입력 데이터 검증
        if inputData.name.isEmpty || inputData.phoneNumber.isEmpty {
            // 에러 처리
            let alert = UIAlertController(
                title: "입력 오류",
                message: "모든 정보를 입력해주세요.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
            return
        }
        
        // 새로운 연락처 생성 및 저장
        let newPhoneBook = PhoneBook(name: inputData.name, phoneNumber: inputData.phoneNumber, imagePath: inputData.imagePath)
        CoreDataManager().createData(phoneBook: newPhoneBook, context: self.container.viewContext)
        
        // 메인 화면으로 돌아가기
        navigationController?.popViewController(animated: true)
    }
    
}
//#Preview {
//    ViewController()
//}

