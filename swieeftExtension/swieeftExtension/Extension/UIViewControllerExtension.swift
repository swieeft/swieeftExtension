//
//  UIViewControllerExtension.swift
//  swieeftExtension
//
//  Created by Park GilNam on 16/04/2019.
//  Copyright © 2019 swieeft. All rights reserved.
//

import UIKit

protocol StoryboardName: class {}
protocol ViewControllerName: class {}

extension StoryboardName where Self:UIViewController {
    static var storyboardName: String {
        return String(describing: self)
    }
}

extension ViewControllerName where Self:UIViewController {
    static var viewControllerName: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardName, ViewControllerName {
    // 뷰컨트롤러 가져오기
    // * 스토리보드, 뷰컨트롤러의 id와 클래스 명이 동일해야함
    static func storyboardInstance<T:UIViewController>() -> T? {
        print("storyboardName : \(self.storyboardName), viewControllerName : \(self.viewControllerName)")
        let vc = UIStoryboard(name: self.storyboardName, bundle: nil).instantiateViewController(withIdentifier: self.viewControllerName) as? T
        return vc
    }
    
    // 뷰컨트롤러 가져오기
    // * 뷰컨트롤러의 id와 클래스 명이 동일해야함
    static func storyboardInstance<T:UIViewController>(storyboardName: String) -> T? {
        print("storyboardName : \(storyboardName), viewControllerName : \(self.viewControllerName)")
        let vc = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: self.viewControllerName) as? T
        return vc
    }
}

extension UIViewController {
    func showToast(message : String, seconds: Double = 2.0) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
}
