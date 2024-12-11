//
//  CoreDataManager.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/12/24.
//
import CoreData

struct CoreDataManager {
    
    func createData(phoneBook: PhoneBook, context: NSManagedObjectContext) {
        guard let entity = NSEntityDescription.entity(forEntityName: "PhoneBookItem", in: context) else { return }
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: context)
        newPhoneBook.setValue(phoneBook.name, forKey: "name")
        newPhoneBook.setValue(phoneBook.phoneNumber, forKey: "phoneNumber")
        newPhoneBook.setValue(phoneBook.imagePath, forKey: "imagePath")
        
        do {
            try context.save()
               print("문맥 저장 성공")
           } catch {
               print("문맥 저장 실패")
           }
    }
    
    func readAllData(context: NSManagedObjectContext) -> [PhoneBook]? {
        
        var phoneBookList = [PhoneBook]()
        
        do {
            let phoneBookItems = try context.fetch(PhoneBookItem.fetchRequest())
            
            for item in phoneBookItems as [NSManagedObject] {
                if let name = item.value(forKey: "name") as? String,
                   let phoneNumber = item.value(forKey: "phoneNumber") as? String,
                   let imagePath = item.value(forKey: "imagePath") as? String {
                    
                    let phoneBook = PhoneBook(name: name, phoneNumber: phoneNumber, imagePath: imagePath)
                    phoneBookList.append(phoneBook)
                }
            }
        } catch {
            print("데이터 읽기 실패")
            return nil
        }
        return phoneBookList.sorted{ $0.name < $1.name }
    }
    
}
