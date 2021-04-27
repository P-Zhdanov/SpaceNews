//
//  API.swift
//  Spac News
//
//  Created by Павел Жданов on 23.04.2021.
//

import UIKit

class API: Codable {
    func getData (info : @escaping(News)->()) {
        let urlString = "https://test.spaceflightnewsapi.net/api/v2/articles"
        guard let url = URL(string: urlString) else {return}
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let news = try JSONDecoder().decode(News.self, from: data)
                info(news)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func downloadImage (from url: String, image: @escaping(Data)->()) {
        guard let imageUrl = URL(string: url) else {return}
        let session = URLSession.shared
        session.dataTask(with: imageUrl) { data, _, error in
            guard let data = data, error == nil else {return}
            image(data)
        }.resume()
    }
}



