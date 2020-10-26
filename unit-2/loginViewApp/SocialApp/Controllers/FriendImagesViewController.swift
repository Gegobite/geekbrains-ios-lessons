//
//  FriendImagesViewController.swift
//  SocialApp
//
//  Created by Игорь Ершов on 24.10.2020.
//

import UIKit

class FriendImagesViewController: UIViewController {

    var images: [UIImage] = []
    var currentImage = 0
    var imageView = UIImageView()
    let slidingImageView = UIImageView()
    var interactiveAnimator: UIViewPropertyAnimator!
    
    func setup(_ images: [UIImage], selectedImage: UIImage){
        self.images = images
        currentImage = self.images.firstIndex(of: selectedImage) ?? 0
        slidingImageView.image = images[currentImage]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.frame = UIScreen.main.bounds
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        self.view.addSubview(imageView)
        
        slidingImageView.frame = UIScreen.main.bounds
        slidingImageView.contentMode = .scaleAspectFit
        self.view.addSubview(slidingImageView)
        view.backgroundColor = .black

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)

    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .left:
                if currentImage == images.count - 1 {
                    currentImage = 0
                }
                else{
                    currentImage += 1
                }
                imageView.image = images[currentImage]
                animateSwipeLeft()
            case .right:
                if currentImage == 0 {
                    currentImage = images.count - 1
                }
                else{
                    currentImage -= 1
                }
                imageView.image = images[currentImage]
                animateSwipeRight()
            case .down:
                self.dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
    }
    
    private func animateSwipeLeft() {
    UIView.animateKeyframes(withDuration: 1,
                            delay: 0,
                            options: .calculationModeCubic,
                            animations: {
                              UIView.addKeyframe(withRelativeStartTime: 0,
                                                 relativeDuration: 0.3,
                                                 animations: {

                                                  self.slidingImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                                                  
                                                  let opacityAnimation = CABasicAnimation(keyPath: "opacity")
                                                  opacityAnimation.fromValue = 1
                                                  opacityAnimation.toValue = 0
                                                  opacityAnimation.duration = 1
                                                  self.slidingImageView.layer.add(opacityAnimation, forKey: nil)
                                                  
                              })

                              UIView.addKeyframe(withRelativeStartTime: 0.3,
                                                 relativeDuration: 0.6,
                                                 animations: {

                                                  self.slidingImageView.alpha = 0
                                                  
                                                  let animation = CABasicAnimation(keyPath: "position.x")
                                                  animation.fromValue = self.imageView.layer.bounds.origin.x + 600
                                                  animation.toValue = self.imageView.layer.bounds.origin.x
                                                  animation.duration = 1
                                                  self.imageView.layer.add(animation, forKey: nil)

                              })
                              
    }, completion: {[weak self] finished in
        self!.slidingImageView.image = self!.images[self!.currentImage]
        self!.slidingImageView.transform = .identity})
  }
  
  private func animateSwipeRight() {
    UIView.animateKeyframes(withDuration: 1,
                            delay: 0,
                            options: .calculationModeCubic,
                            animations: {
                              UIView.addKeyframe(withRelativeStartTime: 0,
                                                 relativeDuration: 0.3,
                                                 animations: {
                                                  
                                                  let animation = CABasicAnimation(keyPath: "position.x")
                                                  animation.fromValue = self.slidingImageView.layer.bounds.origin.x
                                                  animation.toValue = self.slidingImageView.layer.bounds.origin.x + 600
                                                  animation.duration = 1
                                                  self.slidingImageView.layer.add(animation, forKey: nil)
                                                  
                                                  let opacityAnimation = CABasicAnimation(keyPath: "opacity")
                                                  opacityAnimation.fromValue = 0
                                                  opacityAnimation.toValue = 1
                                                  opacityAnimation.duration = 1
                                                  self.slidingImageView.layer.add(opacityAnimation, forKey: nil)
             
                              })
                              
                              UIView.addKeyframe(withRelativeStartTime: 0.3,
                                                 relativeDuration: 0.6,
                                                 animations: {
                                                  self.slidingImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                                               
                                                  let animation = CABasicAnimation(keyPath: "transform.scale")
                                                  animation.fromValue = 0.1
                                                  animation.toValue = 1
                                                  animation.duration = 1
                                                  self.imageView.layer.add(animation, forKey: nil)
                                                  
                              })
                              
    }, completion: {[weak self] finished in
      var counter: Int {
        if self!.currentImage == self!.images.count - 1 {return 0}
        else {return self!.currentImage + 1}
      }
        self!.slidingImageView.image = self!.images[counter]
        self!.slidingImageView.transform = .identity})
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
