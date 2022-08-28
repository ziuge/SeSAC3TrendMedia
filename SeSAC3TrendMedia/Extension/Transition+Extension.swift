//
//  Transition+Extension.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/08/28.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present // navi 없이 present
        case presentNavigation // navi embeded present
        case presentFullScreenNavigation // navi embeded fullscreen
        case push
    }
    
    func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle = .present) {
        
        switch transitionStyle {
        case .present:
            self.present(viewController, animated: true) // viewController -> T()로 바꿔도 되나? 인스턴스 생성한 부분이 무용지물이 됨
        case .presentNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            self.present(navi, animated: true)
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        case .presentFullScreenNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            navi.modalPresentationStyle = .fullScreen
            self.present(navi, animated: true)
        }
    }
}
