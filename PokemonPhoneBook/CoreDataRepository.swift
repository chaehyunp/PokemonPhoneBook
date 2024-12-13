//
//  CoreDataRepository.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/12/24.
//

import Foundation
import CoreData

class CoreDataRepository {
    
    var contacts: [Contact] = [] // 결과 값을 받을 배열
    let persistentContainer: NSPersistentContainer
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // 리스트 읽어오기
    func fetch() {
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        
        // 이름 순으로 정렬
        let sortDiscriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDiscriptor]

        do {
            contacts = try self.context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch contacts: \(error)")
        }
    }
    
    // 저장
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error\(nsError), \(nsError.userInfo)")
            }
        }
    }
}
