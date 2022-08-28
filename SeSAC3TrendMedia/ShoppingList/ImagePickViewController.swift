//
//  ImagePickViewController.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/08/24.
//

import Foundation
import UIKit

class ImagePickViewController: BaseViewController {
    
    var delegate: SelectImageDelegate?
    var selectImage: UIImage?
    
    let mainView = ImagePickView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    override func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(ImagePickCollectionViewCell.self, forCellWithReuseIdentifier: "ImagePickCollectionViewCell")
        
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem = closeButton
        
        let saveButton = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
        
        // 이미지 다운로드 받을 때 아무것도 못하도록 막는 기능들
        view.isUserInteractionEnabled = false
//        mainView.collectionView.isUserInteractionEnabled = false
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func selectButtonClicked() {
        
        guard let selectImage = selectImage else {
            showAlertMessage(title: "사진을 선택해주세요", button: "확인")
            return
        }
        
        delegate?.sendImageData(image: selectImage)
        dismiss(animated: true)
    }
    
}

extension ImagePickViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageDummy.data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagePickCollectionViewCell", for: indexPath) as? ImagePickCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.setImage(data: ImageDummy.data[indexPath.item].url)

        return cell
    }

    // userInteractionEnabled & progress loading 보여주기
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        // 어떤 셀인지 어떤 이미지를 가지고 올 지 어떻게 알지??
//        guard let cell = collectionView.cellForItem(at: indexPath) as? ImagePickCollectionViewCell else { return }
//
////        selectImage = cell.searchImageView.image
//
//        collectionView.reloadData()
//    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        selectImage = nil
        collectionView.reloadData()
    }
}
