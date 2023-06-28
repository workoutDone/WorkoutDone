//
//  GradientButton.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/04.
//

import UIKit

class GradientButton: UIButton {
    let gradient = CAGradientLayer()
    
    var colors : [CGColor] {
        get {
            return gradient.colors as? [CGColor] ?? []
        }
        set {
            gradient.colors = newValue
        }
    }
    
    init(colors: [CGColor]) {
        super.init(frame: .zero)

        gradient.colors = colors
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradient.cornerRadius = 12
        
        layer.addSublayer(gradient)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
}
