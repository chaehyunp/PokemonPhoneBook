//
//  PhoneBook.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/10/24.
//
import UIKit

struct PhoneBook {

    var name: String
    var phoneNumber: String
    var imagePath: String
    
    init(name: String, phoneNumber: String, imagePath: String) {
        self.name = name
        self.phoneNumber = formatPhoneNumber(phoneNumber)
        self.imagePath = imagePath
    }
}

// MARK: - Sample Data
extension PhoneBook {
    static var sampleData: [PhoneBook] = [
        PhoneBook(name: "김민지", phoneNumber: "010-1234-5678", imagePath: ""),
        PhoneBook(name: "팜하니", phoneNumber: "010-2345-6789", imagePath: ""),
        PhoneBook(name: "다니엘", phoneNumber: "010-3456-7890", imagePath: ""),
        PhoneBook(name: "강해린", phoneNumber: "010-4567-8901", imagePath: ""),
        PhoneBook(name: "이혜인", phoneNumber: "010-5678-9012", imagePath: "")
    ]
}


