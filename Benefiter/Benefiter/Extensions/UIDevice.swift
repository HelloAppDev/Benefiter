//
//  UIDevice.swift
//  Benefiter
//
//  Created by Мария Изюменко on 15.10.2022.
//

import UIKit

extension UIDevice {

    var hasNotch: Bool {
        if #available(iOS 13.0, *) {
           return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0 > 0
        }
        return false
    }
    
    var heightNotch: CGFloat{
        get{
            return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0.0
        }
    }
    
}
