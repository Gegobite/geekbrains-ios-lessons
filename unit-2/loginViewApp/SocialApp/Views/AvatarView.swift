//
//  AvatarView.swift
//  SocialApp
//
//  Created by Игорь Ершов on 13.10.2020.
//

import UIKit

@IBDesignable class AvatarView: UIView {

    @IBInspectable var shadowColor: UIColor = .black
    @IBInspectable var shadowOpacity: Float = 0.3 {
        didSet{
            updateShadow()
        }
    }
    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet{
            updateShadow()
        }
    }
    @IBInspectable var shadowRadius : CGFloat = 3 {
        didSet{
            updateShadow()
        }
    }
    
    var imageView: UIImageView?
    var image: UIImage? {
        didSet{
            updateImageView()
            self.setNeedsLayout()
        }
    }
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(onTap))
        recognizer.numberOfTapsRequired = 1    // Количество нажатий, необходимое для распознавания
        recognizer.numberOfTouchesRequired = 1 // Количество пальцев, которые должны коснуться экрана для распознавания
        return recognizer
    }()
    
    @objc func onTap() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
                        self.imageView!.frame.size.height -= 10
                       })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateImageView()
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateImageView()
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func updateImageView(){
        imageView = UIImageView()
        self.addSubview(imageView!)
        let padding: CGFloat = 3
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        imageView?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding).isActive = true
        imageView?.topAnchor.constraint(equalTo: self.topAnchor, constant: padding).isActive = true
        imageView?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding).isActive = true
        imageView?.image = image
    }
    
    private func updateShadow(){
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadow()
        self.layer.cornerRadius = self.frame.size.height / 2
        imageView?.layer.cornerRadius = imageView!.frame.size.height / 2
        imageView?.clipsToBounds = true
    }
}
