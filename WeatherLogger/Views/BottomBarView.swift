//
//  BottomBarView.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/13/20.
//

import UIKit

class BottomBarView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        let gradientLayer = ViewHelper.shared.setGradientBackground(colorTop: UIColor.white, colorBottom: UIColor.white, in: bounds)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
