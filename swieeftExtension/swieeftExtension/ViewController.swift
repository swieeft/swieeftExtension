//
//  ViewController.swift
//  swieeftExtension
//
//  Created by Park GilNam on 16/04/2019.
//  Copyright © 2019 swieeft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var datePicker: UITextField!
    @IBOutlet weak var picker: UITextField!
    
    var datas = ["일번", "이번", "삼번", "사번", "오번"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        number.setDoneButton(target: self, action: #selector(doneButtonClick))
        datePicker.setDatePickerKeyboard(target: self, datePickerAction: #selector(selectDatePicker(sender:)), doneAction: #selector(doneButtonClick))
        picker.setPickerKeyboard(target: self, action: #selector(doneButtonClick), delegate: self, dataSource: self)
    }
    
    @objc func doneButtonClick(sender: Any) {
        self.view.endEditing(true)
    }
    
    @objc func selectDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        datePicker.text = dateFormatter.string(from: sender.date)
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return datas[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        picker.text = datas[row]
    }
}
