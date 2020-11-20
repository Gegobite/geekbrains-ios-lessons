//
//  DotsAnimation.swift
//  SocialApp
//
//  Created by Игорь Ершов on 24.10.2020.
//

import UIKit

class DotsAnimation {

    private var superView: UIView?
    private var dotsView: UIView?
    
    func stopDotsAnimation(dots:UIView?) {
        if dots != nil {
            for subview in (dots?.subviews)! {
                subview.removeFromSuperview()
            }
            dots?.removeFromSuperview()
        }
    }

    func startDotsAnimation(superView:UIView, dotsColor:UIColor) -> UIView {
        self.superView = superView
        dotsView = self.buildView(superView: superView, dotsColor: dotsColor)
        animateWithKeyframes(dotToAnimate: dotsView!.subviews[0], delay: 0.0)
        animateWithKeyframes(dotToAnimate: dotsView!.subviews[1], delay: 0.3)
        animateWithKeyframes(dotToAnimate: dotsView!.subviews[2], delay: 0.6)
        return dotsView!
    }

    private func buildView(superView:UIView, dotsColor:UIColor) -> UIView {
        let dots = UIView(frame: superView.frame)

        dots.backgroundColor = UIColor(white: 1, alpha: 0)
        let numberDots = CGFloat(3)

        let width = CGFloat(dots.frame.width/30)
        let dotDiameter: CGFloat = (dots.frame.height < width) ? dots.frame.height : width
        var frame = CGRect(x: (dots.frame.origin.x + dots.frame.width/2 - 30), y: (dots.frame.origin.y + (dots.frame.height/2) - (dotDiameter/2)), width: dotDiameter, height: dotDiameter)
        let cornerRadiusLocal = dotDiameter / 2

        for _ in 0...Int(numberDots-1) {
            let dot:UIView = UIView(frame:frame)
            dot.layer.cornerRadius = cornerRadiusLocal;
            dot.backgroundColor = dotsColor
            dots.addSubview(dot)
            frame.origin.x += (1.6 * dotDiameter)
        }
        return dots
    }

    private func animateWithKeyframes(dotToAnimate:UIView, delay:Double) {
        UIView.animateKeyframes(
            withDuration: 0.9,
            delay: delay,
            options: [.repeat],
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 0.3,
                    animations: {
                        dotToAnimate.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                    }
                )
                UIView.addKeyframe(
                    withRelativeStartTime: 0.3,
                    relativeDuration: 0.6,
                    animations: {
                        dotToAnimate.transform = CGAffineTransform.identity
                    }
                )
            }
        )
    }
}
