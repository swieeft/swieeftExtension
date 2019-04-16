//
//  UIImageExtension.swift
//  swieeftExtension
//
//  Created by Park GilNam on 16/04/2019.
//  Copyright © 2019 swieeft. All rights reserved.
//

import UIKit

extension UIImage {
    
    // url로 이미지 다운로드
    static func downloadedFrom(url: URL, success: @escaping ((UIImage) -> Void)) {
        
        if let cacheImage = Cache.imageCache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async() {
                success(cacheImage)
            }
        } else {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else {
                        print("Download image fail : \(url)")
                        return
                }
                
                DispatchQueue.main.async() {
                    print("Download image success \(url)")
                    
                    Cache.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    
                    success(image)
                }
                }.resume()
        }
    }
    
    static func downloadedFrom(link: String, success: @escaping ((UIImage) -> Void)) {
        guard let url = URL(string: link) else { return }
        
        downloadedFrom(url: url) { (image) in
            success(image)
        }
    }
}


