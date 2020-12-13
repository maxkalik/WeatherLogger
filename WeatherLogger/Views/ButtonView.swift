//
//  ButtonView.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/12/20.
//

import UIKit

class ButtonView: UIButton {
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        appearance()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.2) { [self] in
            self.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1)
        }
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.2) { [self] in
            self.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
        super.touchesEnded(touches, with: event)
    }
    
    func appearance() {
        titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        layer.cornerRadius = 20
        layer.backgroundColor = UIColor.systemGreen.cgColor
        contentEdgeInsets.left = 40
        contentEdgeInsets.right = 40
    }
    
}
