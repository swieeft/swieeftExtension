//
//  UILabelExtension.swift
//  swieeftExtension
//
//  Created by Park GilNam on 16/04/2019.
//  Copyright © 2019 swieeft. All rights reserved.
//

import UIKit

extension UILabel {
    // 숫자 천단위에 콤마(,)를 넣어 label에 적용
    func decimalFormatString(data:Any) {
        let formatter:NumberFormatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.groupingSeparator = ","
        
        text = formatter.string(for: data)
    }
}
