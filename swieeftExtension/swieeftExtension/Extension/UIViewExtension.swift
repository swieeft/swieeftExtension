//
//  UIViewExtension.swift
//  swieeftExtension
//
//  Created by Park GilNam on 16/04/2019.
//  Copyright © 2019 swieeft. All rights reserved.
//

import UIKit

extension UIView {
    // 뷰에 테두리 추가
    func setBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    // 뷰 모서리 둥글게
    func setCornerRound(cornerRadius: CGFloat)  {
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
    }
    
    // 원형 뷰 만들기 (width, height가 1:1 비율이어야 동그랗게 됨)
    func setCircleView() {
        setCornerRound(cornerRadius: self.bounds.width / 2)
    }
    
    // 뷰 상단 모서리 둥글게
    func roundedTopCorners(){
        clipsToBounds = true
        
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: [.topRight, .topLeft],
                                cornerRadii: CGSize(width: 5, height: 5))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
    
    // 뷰에 TapGesture 추가
    func setTapGesture(target:Any?, action:Selector?) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        isUserInteractionEnabled = true
        addGestureRecognizer(tapGesture)
    }
    
    // 현재 뷰의 부모 뷰 컨트롤러
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    // 뷰 전환 시 애니메이션 적용
    func transitionAnimation(duration: CFTimeInterval, type: CATransitionType, subType: CATransitionSubtype?) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = type
        animation.subtype = subType
        animation.duration = duration
        layer.add(animation, forKey: type.rawValue)
    }
}
