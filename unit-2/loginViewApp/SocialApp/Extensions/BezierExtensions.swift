//
//  BezierExtensions.swift
//  SocialApp
//
//  Created by Игорь Ершов on 14.10.2020.
//

import UIKit

extension UIBezierPath {
    convenience init(heartIn rect: CGRect) {
        self.init()

        let sideOne = rect.width * 0.4
        let sideTwo = rect.height * 0.3
        let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/2

        self.addArc(withCenter: CGPoint(x: rect.width * 0.3, y: rect.height * 0.35), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: true)

        self.addLine(to: CGPoint(x: rect.width/2, y: rect.height * 0.2))

        self.addArc(withCenter: CGPoint(x: rect.width * 0.7, y: rect.height * 0.35), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)

        self.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.95))

        self.close()
    }
}

extension Int {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi/180 }
}
