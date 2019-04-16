//
//  UIAlertControllerExtension.swift
//  swieeftExtension
//
//  Created by Park GilNam on 16/04/2019.
//  Copyright © 2019 swieeft. All rights reserved.
//

import UIKit

extension UIAlertController {
    func setOkAlert(title: String, completionHandler: @escaping () -> Void){
        let okAction = UIAlertAction(title: title, style: .default) {
            action in completionHandler()
        }
        
        addAction(okAction)
    }
    
    func setOkCancelAlert(okTitle: String, cancelTitle: String, completionHandler: @escaping (Bool) -> Void){
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) {
            action in completionHandler(false)
        }
        
        let okAction = UIAlertAction(title: okTitle, style: .default) {
            action in completionHandler(true)
        }
        
        addAction(cancelAction)
        addAction(okAction)
    }
}

