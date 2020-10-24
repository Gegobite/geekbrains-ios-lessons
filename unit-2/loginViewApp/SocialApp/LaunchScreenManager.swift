//
//  LaunchScreenManager.swift
//  SocialApp
//
//  Created by Игорь Ершов on 24.10.2020.
//
import UIKit

class LaunchScreenManager {

    static let instance = LaunchScreenManager(animationDurationBase: 2)

    var view: UIView?
    var parentView: UIView?

    let animationDurationBase: Double

    init(animationDurationBase: Double) {
        self.animationDurationBase = animationDurationBase
    }

    func animateAfterLaunch(_ parentViewPassedIn: UIView) {
        parentView = parentViewPassedIn
        view = loadView()

        fillParentViewWithView()
        
        let animation = DotsAnimation()
        let animationDots = animation.startDotsAnimation(superView: view!, dotsColor: UIColor.white)
        animationDots.frame = view!.frame
        animationDots.center = view!.center
        view!.addSubview(animationDots)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDurationBase * 1.25) {
            self.view!.removeFromSuperview()
        }
    }

    func loadView() -> UIView {
        return UINib(nibName: "LaunchScreenView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

    func fillParentViewWithView() {
        parentView!.addSubview(view!)

        view!.frame = parentView!.bounds
        view!.center = parentView!.center
    }
}
