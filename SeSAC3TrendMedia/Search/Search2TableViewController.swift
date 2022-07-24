//
//  Search2TableViewController.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/07/19.
//

import UIKit

class Search2TableViewController: UITableViewController {
    
    var movieList = MovieInfo()
//    ["암살", "괴물", "해리포터", "라라랜드", "몬스터 주식회사", "몬스터 대학교"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "처음으로 돌아가기", style: .plain, target: self, action: #selector(resetBtnClicked))

    }
    
    @objc func resetBtnClicked() {
        
        // iOS 13+ SceneDelegate 쓸 때 동작하는 코드
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return movieList.movie.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Search2TableViewCell", for: indexPath) as! Search2TableViewCell // as? 타입 캐스팅
        
        let data = movieList.movie[indexPath.row]
        cell.configureCell(data: data)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("didSelectRowAt")
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "RecommandCollectionViewController") as! RecommandCollectionViewController
        
        // 2. 값 전달 - vc가 가지고 있는 프로퍼티에 데이터 넣기
//        let title = movieList.movie[indexPath.row].title
//        let release = movieList.movie[indexPath.row].releaseDate
//        vc.movieTitle = "\(title)(\(release)) "
        vc.movieData = movieList.movie[indexPath.row]
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
