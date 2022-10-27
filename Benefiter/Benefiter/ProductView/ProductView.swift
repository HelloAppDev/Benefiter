//
//  ProductView.swift
//  Benefiter
//
//  Created by Мария Изюменко on 14.10.2022.
//

import UIKit

class ProductView: BaseView {


    @IBOutlet weak var productTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var priceNumbersLabel: UILabel!
    @IBOutlet weak var weightNumbersLabel: UILabel!
    @IBOutlet weak var profitableLabel: UILabel!
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var textFieldsHeight: NSLayoutConstraint!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        profitableLabel.layer.masksToBounds = true
        profitableLabel.layer.cornerRadius = profitableLabel.frame.height / 2
        priceTextField.setShadow(1, 1, 0.2)
        weightTextField.setShadow(1, 1, 0.2)
        profitableLabel.adjustsFontSizeToFitWidth = true
        profitableLabel.minimumScaleFactor = 0.5
    }
}
