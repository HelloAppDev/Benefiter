//
//  MathModule.swift
//  Benefiter
//
//  Created by Мария Изюменко on 19.10.2022.
//

import UIKit

class Mathmodule {
    
    func availableButton(_ fields: [UITextField],_ button: UIButton) {
        fields.forEach { field in
            if field.text != "" {
                button.backgroundColor = #colorLiteral(red: 0.4643478394, green: 1, blue: 0.7415928245, alpha: 1)
            } else {
                button.backgroundColor = #colorLiteral(red: 0.6745098233, green: 0.6745098233, blue: 0.6745098233, alpha: 1)
                
            }
        }
        
    }
    
}
