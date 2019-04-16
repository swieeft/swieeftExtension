//
//  DateExtension.swift
//  swieeftExtension
//
//  Created by Park GilNam on 16/04/2019.
//  Copyright © 2019 swieeft. All rights reserved.
//

import UIKit

extension Date {
    // 원하는 날짜로 Date 생성
    func createDate(year: Int, month: Int, day: Int) -> Date? {
        let calendar = Calendar.current
        
        var components = (calendar as NSCalendar).components([.year, .month, .day], from: self)
        
        components.year = year
        components.month = month
        components.day = day
        
        return calendar.date(from: components)
    }
    
    // Date를 dateFormat 형식에 맞는 String으로 변환
    func toFormatString(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.string(from: self)
    }
}

