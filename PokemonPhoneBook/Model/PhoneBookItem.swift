//
//  PhoneBookItem.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/12/24.
//

import CoreData

@objc(PhoneBookItem)
public class PhoneBookItem: NSManagedObject {
    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var image: String?
}

extension PhoneBookItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneBookItem> {
        return NSFetchRequest<PhoneBookItem>(entityName: "PhoneBookItem")
    }
}
