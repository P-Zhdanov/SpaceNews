//
//  API.swift
//  Spac News
//
//  Created by Павел Жданов on 23.04.2021.
//

import UIKit

class API {
    func getData (info : @escaping([NewsData])->()) {
        let urlString = "https://test.spaceflightnewsapi.net/api/v2/articles"
        guard let url = URL(string: urlString) else {return}
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {return}
            do {
                print(data)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601withFractionalSeconds
                let news = try decoder.decode([NewsData].self, from: data)
                print(news)
                info(news)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func downloadImage (from url: String, image: @escaping(Data)->()) -> URLSessionDataTask? {
        if let imageUrl = URL(string: url) {
            let session = URLSession.shared
            let task = session.dataTask(with: imageUrl) { data, _, error in
                guard let data = data, error == nil else {return}
                image(data)
            }
            return task
        }
        return nil
    }
}



