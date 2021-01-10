//
//  LikeButton.swift
//  SocialApp
//
//  Created by Игорь Ершов on 13.10.2020.
//

import UIKit

@IBDesignable class LikeButton: UIButton {

    @IBInspectable var filled: Bool = true
    @IBInspectable var strokeWidth: CGFloat = 2.0
    @IBInspectable var strokeColor: UIColor = UIColor.red
    
    var isLiked: Bool = false
    
    override func draw(_ rect: CGRect) {
        let bezierPath = UIBezierPath(heartIn: self.bounds)
      
      if (!isLiked) {
        strokeColor = self.tintColor
        self.strokeColor.setStroke()
        self.filled = false
      } else {
        strokeColor = UIColor.red
        self.tintColor = UIColor.red
        self.strokeColor.setStroke()
        self.tintColor.setFill()
        bezierPath.fill()
      }
      bezierPath.lineWidth = self.strokeWidth
      bezierPath.stroke()
    }
}
