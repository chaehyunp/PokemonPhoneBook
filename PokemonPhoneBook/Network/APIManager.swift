//
//  Network.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/11/24.
//
import UIKit

struct APIManager {
    private let pokemonImagePath = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/" + String(Int.random(in: 1...1025)) + ".png"
    
    func getPokemonImageUrl() -> URL? {
        guard let url = URL(string: pokemonImagePath) else {
            print("잘못된 URL")
            return nil
        }
        return url
    }
    
}
