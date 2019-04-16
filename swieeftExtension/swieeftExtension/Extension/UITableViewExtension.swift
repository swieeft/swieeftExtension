//
//  UITableViewExtension.swift
//  swieeftExtension
//
//  Created by Park GilNam on 16/04/2019.
//  Copyright © 2019 swieeft. All rights reserved.
//

import UIKit

extension UITableView {
    // cells에 포함된 모든 셀을 register
    func registerAll(cells: UITableViewCell.Type...) {
        cells.forEach { (cell) in
            cell.register(tableView: self)
        }
    }
    
    // 테이블 뷰 초기화
    func initTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource, allowSelection: Bool = true, separatorStyle: UITableViewCell.SeparatorStyle = .none, estimatedRowHeight: CGFloat = 100, showsVerticalScrollIndicator: Bool = true, showsHorizontalScrollIndicator: Bool = true) {
        self.delegate = delegate
        self.dataSource = dataSource
        self.allowsSelection = allowSelection
        self.separatorStyle = separatorStyle
        self.estimatedRowHeight = estimatedRowHeight
        self.rowHeight = UITableView.automaticDimension
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        self.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
    }
}

