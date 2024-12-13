//
//  ImageRepository.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/12/24.
//

import Foundation
import UIKit

class ImageRepository {
    
    func fetchRandomPokemonImage(completion: @escaping (UIImage?) -> Void) {
        let randomId = Int.random(in: 1...1025)
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(randomId)"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                  let sprites = json["sprites"] as? [String: Any],
                  let imageUrlString = sprites["front_default"] as? String,
                  let imageUrl = URL(string: imageUrlString) else {
                completion(nil)
                return
            }
            self.downloadImage(from: imageUrl, completion: completion)
        }
        task.resume()
    }
    
    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: url),
               let image = UIImage(data: imageData) {
                   DispatchQueue.main.async {
                       completion(image)
                   }
               } else {
                   DispatchQueue.main.async {
                       completion(nil)
                   }
               }
        }
    }
}
