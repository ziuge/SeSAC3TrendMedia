//
//  Search2TableViewController.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/07/19.
//

import UIKit

class Search2TableViewController: UITableViewController {
    
    var movies = [Movie(title: "암살", movieDate: "22.22.22", movieOverview: "암살 줄거리", movieRuntime: 150, movieRate: 9.0), Movie(movieTitle: "괴물", movieDate: "88.88.88", movieOverview: "괴물 줄거리", movieRuntime: 130, movieRate: 5.6)]
//    ["암살", "괴물", "해리포터", "라라랜드", "몬스터 주식회사", "몬스터 대학교"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Search2TableViewCell", for: indexPath) as! Search2TableViewCell // as? 타입 캐스팅
        
        let data = movies[indexPath.row]
        cell.configureCell(data: data)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }
}
