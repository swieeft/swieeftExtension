//
//  UIImageViewExtension.swift
//  swieeftExtension
//
//  Created by Park GilNam on 16/04/2019.
//  Copyright © 2019 swieeft. All rights reserved.
//

import UIKit

class Cache {
    static let imageCache = NSCache<NSString, UIImage>()
}

extension UIImageView {
    
    // url로 이미지 다운로드
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleToFill) {
        
        self.contentMode = mode
        
        if let cacheImage = Cache.imageCache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async() {
                self.image = cacheImage
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
                    
                    self.image = image
                }
                }.resume()
        }
    }
    
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleToFill) {
        guard let url = URL(string: link) else { return }
        
        downloadedFrom(url: url, contentMode: mode)
    }
}

