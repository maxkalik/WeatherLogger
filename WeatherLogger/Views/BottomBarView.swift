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
        
        switch traitCollection.userInterfaceStyle {
        case .dark:
            setup(with: UIColor.black)
        default:
            setup(with: UIColor.white)
        }
    }
    
    func setup(with color: UIColor) {
        let gradientLayer = ViewHelper.shared.setGradientBackground(colorTop: color, colorBottom: color, in: bounds)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
