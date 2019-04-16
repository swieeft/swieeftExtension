//
//  UITableViewCellExtension.swift
//  swieeftExtension
//
//  Created by Park GilNam on 16/04/2019.
//  Copyright © 2019 swieeft. All rights reserved.
//

import UIKit

protocol ReusableView: class {}

protocol NibLoadableView: class {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension NibLoadableView where Self: UIView {
    static var NibName: String {
        return String(describing: self)
    }
}

extension UITableViewCell : ReusableView, NibLoadableView {
    // 테이블 뷰에 커스텀 셀 클래스를 바로 register 할 수 있도록 해주는 Extension
    // * 셀 ID를 셀 클래스명과 동일하게 작성해야됨
    static func register(tableView: UITableView) {
        let Nib = UINib(nibName: self.NibName, bundle: nil)
        tableView.register(Nib, forCellReuseIdentifier: self.reuseIdentifier)
    }
    
    // 테이블 뷰에 커스텀 셀 클래스를 바로 dequeueReusableCell 할 수 있도록 해주는 Extension
    // * 셀 ID를 셀 클래스명과 동일하게 작성해야됨
    static func dequeueReusableCell(tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier) else {
            fatalError("Error! \(self.reuseIdentifier)")
        }
        
        return cell
    }
    
    // 현재 셀의 부모 테이블 뷰
    var parentTableView: UITableView? {
        return next(UITableView.self)
    }
    
    // 현재 셀의 IndexPath
    var cellIndexPath: IndexPath? {
        return parentTableView?.indexPath(for: self)
    }
}



