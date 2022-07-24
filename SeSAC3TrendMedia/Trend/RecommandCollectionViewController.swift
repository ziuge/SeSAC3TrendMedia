//
//  RecommandCollectionViewController.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/07/20.
//

import UIKit
import Toast
import Kingfisher


class RecommandCollectionViewController: UICollectionViewController {
    
    // 1. 값 전달 - 데이터를 받을 공간(프로퍼티) 생성
    var movieData: Movie?
    // 따로따로 프로퍼티 생성하지 않고 하나의 구초제 전체를 전달받는 이유? -> 깔끔하고 효율적임
    
    
    var imageURL = "https://search.pstatic.net/common?quality=75&direct=true&src=https%3A%2F%2Fmovie-phinf.pstatic.net%2F20220607_129%2F16545872892918GA4h_JPEG%2Fmovie_image.jpg"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 3. 값 전달 - 프로퍼티 값을 뷰에 표현
        title = movieData?.title
        
        
        // 컬렉션 뷰의 셀 크기, 셀 사이 간격 등 설정 (Estimate Size -> None으로 설정!)
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.2)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout


    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommandCollectionViewCell", for: indexPath) as? RecommandCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.posterImgView.backgroundColor = .orange
        
        let url = URL(string: imageURL)
        cell.posterImgView.kf.setImage(with: url)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.makeToast("\(indexPath.item)번째 셀을 선택했습니다.", duration: 1, position: .center)
        
        self.navigationController?.popViewController(animated: true)
    }

}
