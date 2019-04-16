//
//  StringExtension.swift
//  swieeftExtension
//
//  Created by Park GilNam on 16/04/2019.
//  Copyright © 2019 swieeft. All rights reserved.
//

import UIKit
import CommonCrypto

extension String {
    // 한글 이름인지 확인
    var validateNameKorean: Bool {
        let nameRegEx = "^[가-힣]{2,15}$"
        return self.checkString(filter: nameRegEx)
    }
    
    // 유효한 이메일 형식인지 확인
    var validateEmail: Bool {
        let emailRegEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: self)
    }
    
    func checkString(filter: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: filter) else {
            return false
        }
        
        let range = NSRange(location: 0, length: self.utf16.count)
        let isMatch = regex.firstMatch(in: self, options: [], range: range) != nil
        
        return isMatch
    }
    
    // String형식의 날짜를 원하는 날짜 형식으로 변환 (ex. from: yyyyMMdd -> to: yyyy년 MM월 dd일)
    func displayDateFormat( from: String, to: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        dateFormatter.dateFormat = from
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = to
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    // String형식의 날짜를 Date형으로 변환
    func toDate(dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.date(from: self)
    }
    
    // AES128 암호화
    var encryptAES128: String? {
        let key = "abcd123" as NSString
        let iv = "123123abcd" as NSString
        
        let data = self.data(using: String.Encoding.utf8)! as NSData
        
        let keyPtr = UnsafeMutablePointer<CChar>.allocate(capacity: Int() + 1)
        
        defer {
            keyPtr.deallocate()
        }
        
        let ivPtr = iv.utf8String
        bzero(keyPtr, 0)
        key.getCString(keyPtr, maxLength: Int(kCCKeySizeAES128) + 1, encoding: String.Encoding.utf8.rawValue)
        
        let bufferSize = data.length + kCCBlockSizeAES128
        let buffer = UnsafeMutableRawPointer.allocate(byteCount: bufferSize, alignment: MemoryLayout.alignment(ofValue: CChar.self))
        
        var numBytesEncrypted = 0
        
        let cryptStatus = CCCrypt(CCOperation(kCCEncrypt), CCAlgorithm(kCCAlgorithmAES128), CCOptions(kCCOptionPKCS7Padding), keyPtr, kCCKeySizeAES128, ivPtr, data.bytes, data.length, buffer, bufferSize, &numBytesEncrypted)
        
        if cryptStatus == kCCSuccess {
            let data = NSData(bytesNoCopy: buffer, length: numBytesEncrypted, freeWhenDone: true).base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            return data
        }
        
        buffer.deallocate()
        return nil
    }
    
    // AES128 복호화
    var decryptAES128: String? {
        guard let data = Data(base64Encoded: self, options: []) as NSData? else {
            return nil
        }
        
        let key = "abcd123"
        let iv = "123123abcd"
        
        if let keyData = key.data(using: String.Encoding.utf8) as NSData?, let cryptData = NSMutableData(length: Int((data.length)) + kCCBlockSizeAES128) {
            
            let keyLength = size_t(kCCKeySizeAES128)
            
            let operation: CCOperation = CCOperation(kCCDecrypt)
            let algoritm:  CCAlgorithm = CCAlgorithm(kCCAlgorithmAES128)
            let options:   CCOptions   = CCOptions(kCCOptionPKCS7Padding)
            
            var numBytesEncrypted :size_t = 0
            
            let cryptStatus = CCCrypt(operation, algoritm, options, keyData.bytes, keyLength, iv, data.bytes, data.length, cryptData.mutableBytes, cryptData.length, &numBytesEncrypted)
            
            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                cryptData.length = Int(numBytesEncrypted)
                return String(data: cryptData as Data, encoding: String.Encoding.utf8)
            }
        }
        
        return nil
    }
}


