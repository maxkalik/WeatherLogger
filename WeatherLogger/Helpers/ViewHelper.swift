//
//  ViewHelper.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/13/20.
//

import UIKit

class ViewHelper {
    
    static let shared = ViewHelper()
    private init() {}
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor, in bounds: CGRect) -> CAGradientLayer {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [colorBottom.withAlphaComponent(1).cgColor, colorTop.withAlphaComponent(0.5).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds

        return gradientLayer
    }
}
