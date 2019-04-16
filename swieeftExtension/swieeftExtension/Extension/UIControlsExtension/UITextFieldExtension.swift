//
//  UITextFieldExtension.swift
//  swieeftExtension
//
//  Created by Park GilNam on 16/04/2019.
//  Copyright © 2019 swieeft. All rights reserved.
//

import UIKit

extension UITextField {
    func setDoneButton(target: Any?, action: Selector) {
        let toolBarKeyboard = UIToolbar()
        toolBarKeyboard.sizeToFit()
        
        let doneBarButton = UIBarButtonItem(title: "완료", style: .done, target: target, action: action)
        toolBarKeyboard.items = [doneBarButton]
        toolBarKeyboard.isUserInteractionEnabled = true
        
        self.inputAccessoryView = toolBarKeyboard
    }
    
    func setCustomInputViewKeyboard(inputView: UIView?, target: Any?, action: Selector) {
        setDoneButton(target: target, action: action)
        
        self.inputView = inputView
    }
    
    func setDatePickerKeyboard(target: Any?, datePickerAction: Selector, doneAction: Selector) {
        let datePicker = UIDatePicker()
        datePicker.date = Date()
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.locale = Locale(identifier: "ko_kr")
        datePicker.timeZone = TimeZone(identifier: "KST")
        datePicker.addTarget(target, action: datePickerAction, for: .valueChanged)
        
        setCustomInputViewKeyboard(inputView: datePicker, target: target, action: doneAction)
    }
    
    func setPickerKeyboard(target: Any?, action: Selector, delegate: UIPickerViewDelegate, dataSource: UIPickerViewDataSource) {
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 200, width: frame.width, height: 200))
        pickerView.backgroundColor = .white
        
        pickerView.showsSelectionIndicator = true
        pickerView.delegate = delegate
        pickerView.dataSource = dataSource
        
        setCustomInputViewKeyboard(inputView: pickerView, target: target, action: action)
    }
}

