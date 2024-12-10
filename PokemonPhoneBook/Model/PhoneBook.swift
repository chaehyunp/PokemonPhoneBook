//
//  PhoneBook.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/10/24.
//

struct PhoneBook {
    let image: String?
    let name: String
    let phoneNumber: String

    init(name: String, phoneNumber: String, image: String? = nil) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.image = image
    }
}

// MARK: - Sample Data
extension PhoneBook {
    static let sampleData: [PhoneBook] = [
        PhoneBook(name: "김민지", phoneNumber: "010-1234-5678", image: ""),
        PhoneBook(name: "팜하니", phoneNumber: "010-2345-6789", image: ""),
        PhoneBook(name: "다니엘", phoneNumber: "010-3456-7890", image: ""),
        PhoneBook(name: "강해린", phoneNumber: "010-4567-8901", image: ""),
        PhoneBook(name: "이혜인", phoneNumber: "010-5678-9012", image: "")
    ]
}

// MARK: - Hashable & Equatable
//extension PhoneBook: Hashable {
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(phoneNumber)
//    }
//    
//    static func == (lhs: PhoneBook, rhs: PhoneBook) -> Bool {
//        return lhs.phoneNumber == rhs.phoneNumber
//    }
//}


