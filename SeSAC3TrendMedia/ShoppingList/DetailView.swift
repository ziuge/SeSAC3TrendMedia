//
//  DetailView.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/08/26.
//

import UIKit

class DetailView: BaseView {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let titleTextField: UITextField = {
        let view = UITextField()
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    override func configureUI() {
        [imageView, titleTextField].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(200)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(50)
        }
    }
    
}
