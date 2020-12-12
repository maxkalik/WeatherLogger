//
//  ButtonView.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/12/20.
//

import UIKit

class ButtonView: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        layer.cornerRadius = 20
        layer.backgroundColor = UIColor.systemGreen.cgColor
        contentEdgeInsets.left = 40
        contentEdgeInsets.right = 40
    }
}
