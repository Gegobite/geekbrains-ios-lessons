//
//  LaunchViewController.swift
//  SocialApp
//
//  Created by Игорь Ершов on 23.10.2020.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var dotsImageVIew: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showAnimatingDotsInImageView()
    }
    
    func showAnimatingDotsInImageView() {
        
        let lay = CAReplicatorLayer()
        lay.frame = CGRect(x: 0, y: 8, width: 15, height: 7) //yPos == 12
        let circle = CALayer()
        circle.frame = CGRect(x: 0, y: 0, width: 7, height: 7)
        circle.cornerRadius = circle.frame.width / 2
        circle.backgroundColor = UIColor(red: 110/255.0, green: 110/255.0, blue: 110/255.0, alpha: 1).cgColor//lightGray.cgColor //UIColor.black.cgColor
        lay.addSublayer(circle)
        lay.instanceCount = 3
        lay.instanceTransform = CATransform3DMakeTranslation(10, 0, 0)
        let anim = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        anim.fromValue = 1.0
        anim.toValue = 0.2
        anim.duration = 1
        anim.repeatCount = .infinity
        circle.add(anim, forKey: nil)
        lay.instanceDelay = anim.duration / Double(lay.instanceCount)
        
        dotsImageVIew!.layer.addSublayer(lay)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
