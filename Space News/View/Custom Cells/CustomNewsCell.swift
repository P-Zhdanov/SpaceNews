//
//  CustomSpaceNewsCell.swift
//  Spac News
//
//  Created by Павел Жданов on 23.04.2021.
//

import UIKit

class CustomNewsCell: UITableViewCell {
    @IBOutlet var newsImage: UIImageView!
    @IBOutlet var newsBackground: UIView!
    @IBOutlet var newsPublishedTime: UILabel!
    @IBOutlet var newsTitle: UILabel!
    
    let api = API()
    var downloadTask: URLSessionDataTask?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.downloadTask?.cancel()
    }
    
    func configurationWithNews (_ news: NewsData) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm"
        let dateWithNewFormate = dateFormatter.string(from: news.publishedAt)
        self.newsPublishedTime.text = dateWithNewFormate
        self.newsTitle.text = news.title
        self.downloadTask = self.api.downloadImage(from: news.imageURL) { data in
            DispatchQueue.main.async {
                self.newsImage.image = UIImage(data: data)
            }
        }
        self.downloadTask?.resume()
    }
    
    
}
