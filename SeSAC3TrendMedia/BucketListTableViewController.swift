//
//  BucketListTableViewController.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/07/19.
//

import UIKit

class BucketListTableViewController: UITableViewController {
    
    var list = ["범죄도시2", "탑건", "토르"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BucketListTableViewCell", for: indexPath) as! BucketListTableViewCell // as? 타입 캐스팅
        
        cell.bucketListLabel.text = list[indexPath.row]
        cell.bucketListLabel.font = .boldSystemFont(ofSize: 18)
        
        return cell
    }

}
