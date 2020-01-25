//
//  CustomBtn1.swift
//  CoreDataPro
//
//  Created by Mehedi Hasan on 23/1/20.
//  Copyright © 2020 Mehedi Hasan. All rights reserved.
//

import UIKit

class CustomBtn1: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    private func setupButton() {
        backgroundColor     = UIColor.green
        titleLabel?.font    = UIFont(name: Fonts.avenirNextCondensedDemiBold, size: 22)
        layer.cornerRadius  = frame.size.height/2
        setTitleColor(.white, for: .normal)
    }
}
