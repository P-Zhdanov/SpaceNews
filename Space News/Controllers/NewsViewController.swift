//
//  ViewController.swift
//  Spac News
//
//  Created by Павел Жданов on 23.04.2021.
//

import UIKit

class NewsViewController: UITableViewController {
    
    @IBOutlet var newsTableView: UITableView!
    
    var newsArray: News = News()
    var api = API()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "customNewsCell")
        newsTableView.backgroundColor = UIColor.systemBackground
        updateNewsData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customNewsCell", for: indexPath) as! CustomNewsCell
        self.api.downloadImage(from: newsArray[indexPath.row].imageURL) { data in
            DispatchQueue.main.async {
                cell.newsImage.image = UIImage(data: data)
            }
        }
        cell.newsTitle.text = newsArray[indexPath.row].title
        cell.newsPublishedTime.text = newsArray[indexPath.row].publishedAt
        return cell
    }
    
    func updateNewsData() {
        self.api.getData { info in
            self.newsArray = info
            DispatchQueue.main.async {
                self.newsTableView.reloadData()
            }
        }
    }
}

