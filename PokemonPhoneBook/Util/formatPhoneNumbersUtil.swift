//
//  formatPhoneNumbersUtil.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/12/24.
//
import CoreData

func formatPhoneNumber(_ number: String) -> String {
    // 숫자만 추출
    let digits = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    
    guard digits.count == 11 else { return number } // 11자리가 아니면 원본 반환
    
    // 3-4-4 형식으로 분할z
    let index1 = digits.index(digits.startIndex, offsetBy: 3)
    let index2 = digits.index(digits.startIndex, offsetBy: 7)
    
    let part1 = digits[..<index1]
    let part2 = digits[index1..<index2]
    let part3 = digits[index2...]
    
    // 하이픈으로 연결
    return "\(part1)-\(part2)-\(part3)"
}
