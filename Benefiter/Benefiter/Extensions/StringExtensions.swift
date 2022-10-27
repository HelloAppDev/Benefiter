//
//  StringExtensions.swift
//  Benefiter
//
//  Created by Мария Изюменко on 19.10.2022.
//

import UIKit

extension String {
    
    func imDigits() -> Bool {
        
            let phoneRegEx = "^[0-9+]{0,1}+[0-9]{5,16}$"
            let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
            return phonePred.evaluate(with: self)
        
    }
    
    
}
