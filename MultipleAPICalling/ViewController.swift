//
//  ViewController.swift
//  MultipleAPICalling
//
//  Created by Arpit iOS Dev. on 12/06/24.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var famousTableView: UITableView!
    @IBOutlet weak var tagsTableView: UITableView!
    
    let quotesURL = "https://andruxnet-random-famous-quotes.p.rapidapi.com"
    let tagsURL = "https://tags-generator.p.rapidapi.com/youtubeTags/bollywood"
    let rapidAPIKey = "e103305047msh67c54e4389f5e37p106668jsn6f55a35f4271"
    
    var quotes = [WelcomeElement]()
    var tags = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        famousTableView.delegate = self
        famousTableView.dataSource = self
        tagsTableView.delegate = self
        tagsTableView.dataSource = self
        
        
        fetchData()
    }
    
    func fetchData() {
            DispatchQueue.global(qos: .userInitiated).async {
                self.fetchRandomQuote()
                sleep(3) 
                self.fetchYouTubeTags()
            }
        }
    
    func fetchRandomQuote() {
        let headers: HTTPHeaders = [
            "X-RapidAPI-Key": rapidAPIKey
        ]
        
        let parameters: Parameters = [
            "cat": "movies",
            "count": 5
        ]
        
        AF.request(quotesURL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseDecodable(of: Welcome.self) { response in
                   switch response.result {
                   case .success(let quotes):
                       self.quotes = quotes
                       DispatchQueue.main.async {
                           self.famousTableView.reloadData()
                       }
                   case .failure(let error):
                       print("Error fetching quotes: \(error)")
                   }
               }
           }
    
    
    func fetchYouTubeTags() {
        let headers: HTTPHeaders = [
            "X-RapidAPI-Key": rapidAPIKey
        ]
        
        AF.request(tagsURL, method: .get, headers: headers).responseDecodable(of: Tags.self) { response in
                    switch response.result {
                    case .success(let tagResponse):
                        self.tags = tagResponse.data.tags
                        DispatchQueue.main.async {
                            self.tagsTableView.reloadData()
                        }
                    case .failure(let error):
                        print("Error fetching tags: \(error)")
                    }
                }
            }
    
    
}

// MARK: - TableView Dalegate & Datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if tableView == famousTableView {
            return quotes.count
        } else if tableView == tagsTableView {
            return tags.count
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == famousTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FamousTableViewCell") as! FamousTableViewCell
            cell.quoteLbl.text = quotes[indexPath.row].quote
            cell.authorLbl.text = quotes[indexPath.row].author
            cell.categoryLbl.text = quotes[indexPath.row].category
            return cell
        } else if tableView == tagsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TagsTableViewCell") as! TagsTableViewCell
            cell.tagsLbl.text = tags[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == famousTableView {
            return 101
        } else if tableView == tagsTableView {
            return 57
        } else {
            return 0
        }
    }
}
