//
//  TrendTableViewController.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/07/21.
//

import UIKit

class TrendTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func movieBtnClicked(_ sender: UIButton) {
        // 화면 전환 : 1. 전환하고자 하는 스토리보드 파일 찾고 -> 2. 스토리보드 내에 뷰컨트롤러 찾고 -> 3. 화면 전환을 하면 됨1
        // 영화 버튼 클릭 -> BucketListTableViewController Present
        // 1.
        let storyboard = UIStoryboard(name: "Trend", bundle: nil) // 같은 프로젝트에 있는 걸 가져올 때는 bundle: nil. 아닌 경우? 라이브러리나 다른 모듈에서 가져올 때
        // 2.
        let vc = storyboard.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        // 3.
        self.present(vc, animated: true)
        
    }
    
    @IBAction func dramaBtnClicked(_ sender: UIButton) {
        // 1.
        let storyboard = UIStoryboard(name: "Trend", bundle: nil) // 같은 프로젝트에 있는 걸 가져올 때는 bundle: nil. 아닌 경우? 라이브러리나 다른 모듈에서 가져올 때
        // 2.
        let vc = storyboard.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        // 2.5. present 시 화면 전환 방식 설정 (옵션)
        vc.modalPresentationStyle = .fullScreen
        // 3.
        self.present(vc, animated: true)
    
    }
    
    @IBAction func bookBtnClicked(_ sender: UIButton) {
        // 1.
        let storyboard = UIStoryboard(name: "Trend", bundle: nil) // 같은 프로젝트에 있는 걸 가져올 때는 bundle: nil. 아닌 경우? 라이브러리나 다른 모듈에서 가져올 때
        // 2.
        let vc = storyboard.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        
        // 2.5. 네비게이션 임베드하기
        let nav = UINavigationController(rootViewController: vc)
        
        // 2.5. present 시 화면 전환 방식 설정 (옵션)
        nav.modalPresentationStyle = .fullScreen
        
        // 3.
        self.present(nav, animated: true)
    }
    
}
