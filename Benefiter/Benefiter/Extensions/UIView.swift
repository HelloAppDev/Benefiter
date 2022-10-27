//
//  UIView.swift
//  Benefiter
//
//  Created by Мария Изюменко on 14.10.2022.
//

import Foundation
import UIKit

@IBDesignable extension UIView {
    
    @IBInspectable var borderColor: UIColor? {
        
        get {
            guard let cgColor = layer.borderColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var conrerRadius: CGFloat {
        
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    func bindFrameToSuperViewBounds(topConstant: CGFloat = 0.0,
                                    bottomConstant: CGFloat = 0.0,
                                    leadingConstant: CGFloat = 0.0,
                                    trailingConstant: CGFloat = 0.0) {
        guard let superview = self.superview else { return }
        
        bindFrameToViewBounds(view: superview,
                              topConstant: topConstant,
                              bottomConstant: bottomConstant,
                              leadingConstant: leadingConstant,
                              trailingConstant: trailingConstant)
    }
    
    func bindFrameToViewBounds(view: UIView,
                               topConstant: CGFloat? = 0.0,
                               bottomConstant: CGFloat? = 0.0,
                               leadingConstant: CGFloat? = 0.0,
                               trailingConstant: CGFloat? = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let topConstant = topConstant {
            topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant).isActive = true
        }
        if let bottomConstant = bottomConstant {
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomConstant).isActive = true
        }
        if let leadingConstant = leadingConstant {
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingConstant).isActive = true
        }
        if let trailingConstant = trailingConstant {
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailingConstant).isActive = true
        }
    }
    
    
    func setShadow(_ offsetWidth: Int,_ offsetHeight: Int,_ opacity: Float) {
        layer.shadowOffset = CGSize(width: offsetWidth, height: offsetHeight)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = opacity
    }
    
    func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0

        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }

//    func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
//        self.alpha = 1.0
//
//        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
//            self.alpha = 0.0
//        }) { (completed) in
//            self.isHidden = true
//            completion(true)
//        }
//      }
}
