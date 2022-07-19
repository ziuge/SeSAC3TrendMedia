//
//  Setting2TableViewController.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/07/18.
//

import UIKit

class Setting2TableViewController: UITableViewController {
    
    var settingArray = [["공지사항", "실험실", "버전 정보"], ["개인/보안", "알림", "채팅", "멀티프로필"], ["고객센터/도움말"]]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    // 섹션의 개수
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 3
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "전체 설정"
        } else if section == 1 {
            return "개인 설정"
        } else {
            return "기타"
        }
            
    }

    // 셀의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return settingArray[section].count

    }
    
    // 셀 디자인
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "setting2Cell")!
        
        if indexPath.section == 0 {
            cell.textLabel?.text = settingArray[0][indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel?.text = settingArray[1][indexPath.row]
        } else if indexPath.section == 2 {
            cell.textLabel?.text = settingArray[2][indexPath.row]
        }
//        cell.textLabel?.text = settingArray[indexPath.section][indexPath.row]
            
        return cell
    }

}
