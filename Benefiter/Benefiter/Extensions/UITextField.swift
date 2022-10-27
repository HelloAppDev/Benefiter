//
//  UITextField.swift
//  Benefiter
//
//  Created by Мария Изюменко on 19.10.2022.
//

import UIKit

extension UITextField {
    
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount,
                                 height: self.frame.size.height))
        paddingView.backgroundColor = .clear
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    
}
