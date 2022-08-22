//
//  Setting2TableViewController.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/07/18.
//

import UIKit

enum SettingOptions: Int, CaseIterable {
    case total, personal, other // 섹션
    var sectionTitle: String {
        switch self {
        case .total:
            return "전체 설정"
        case .personal:
            return "개인 설정"
        case .other:
            return "기타"
        }
    }
    var rowTitle: [String] {
        switch self {
        case .total:
            return ["공지사항", "실험실", "버전 정보"]
        case .personal:
            return ["개인/보안", "알림", "채팅", "멀티프로필"]
        case .other:
            return ["고객센터/도움말"]
        }
    }
}

class Setting2TableViewController: UITableViewController {
    
//    var settingArray = [["공지사항", "실험실", "버전 정보"], ["개인/보안", "알림", "채팅", "멀티프로필"], ["고객센터/도움말"]]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    // 섹션의 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingOptions.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingOptions.allCases[section].sectionTitle
    }

    // 셀의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SettingOptions.allCases[section].rowTitle.count
    }
    
    // 셀 디자인
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setting2Cell")!
        cell.textLabel?.text = SettingOptions.allCases[indexPath.section].rowTitle[indexPath.row]
        return cell
    }

}
