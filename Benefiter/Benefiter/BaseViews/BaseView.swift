//
//  BaseView.swift
//  Benefiter
//
//  Created by Мария Изюменко on 14.10.2022.
//

import UIKit

class BaseView: UIView {
    
    var view: UIView!
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit() {
        self.backgroundColor = .clear
        self.view = Bundle.main.loadNibNamed("\(self.classForCoder)", owner: self, options: nil)?.first as? UIView ?? UIView()
        addSubview(view)
        view.bindFrameToSuperViewBounds()
    }
}
