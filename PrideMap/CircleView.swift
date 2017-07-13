//
//  CircleView.swift
//  PrideMap
//
//  Created by Felix Hedlund on 2017-07-13.
//  Copyright © 2017 Felix Hedlund. All rights reserved.
//

import UIKit

class CircleView: UIView {
    @IBOutlet weak var cheerContainer: UIView!

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.layer.cornerRadius = rect.width/2
    }
 
    func animateWithColor(color: UIColor){
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.5) { 
            self.backgroundColor = color
        }
    }

}
