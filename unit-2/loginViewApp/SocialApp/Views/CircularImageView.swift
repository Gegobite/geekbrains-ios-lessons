//
//  CircularImageView.swift
//  SocialApp
//
//  Created by Игорь Ершов on 13.10.2020.
//

import UIKit

@IBDesignable class CircularImageView: UIImageView {

    init(){
        super.init(frame: .zero)
        setCornerRadius()
    }
    
   override init(frame: CGRect) {
    super.init(frame: frame)
    setCornerRadius()
   }
   
   required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setCornerRadius()
   }
   
   override func prepareForInterfaceBuilder() {
    setCornerRadius()
   }
   
   func setCornerRadius() {
    layer.cornerRadius = self.frame.width / 2
   }
}
