//
//  CustomButton.swift
//  BrainTeaser
//
//  Created by Shivam Kapur on 15/03/16.
//  Copyright © 2016 Shivam Kapur. All rights reserved.
//

import Foundation
import UIKit
import pop

@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        
        self.addTarget(self, action: "scaleSmallAnimation", forControlEvents: .TouchDown)
        self.addTarget(self, action: "scaleSmallAnimation", forControlEvents: .TouchDragEnter)
        self.addTarget(self, action: "scaleSpringAnimation", forControlEvents: .TouchUpInside)
        self.addTarget(self, action: "scaleToDefaultAnimation", forControlEvents: .TouchDragExit)
    }
    
    func scaleSmallAnimation() {
        var smallAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        smallAnim.toValue = NSValue(CGPoint: CGPointMake(0.95, 0.95))
        self.layer.pop_addAnimation(smallAnim, forKey: "scaleSmallAnimation")
    }
    
    func scaleSpringAnimation() {
        var springAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        springAnim.velocity = NSValue(CGSize: CGSizeMake(3.0, 3.0))
        springAnim.springBounciness = 18
        springAnim.toValue = NSValue(CGPoint: CGPointMake(1.0, 1.0))
        self.layer.pop_addAnimation(springAnim, forKey: "scaleSpringAnimation")
    }
    
    func scaleToDefaultAnimation() {
        var scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.toValue = NSValue(CGPoint: CGPointMake(1.0, 1.0))
        self.layer.pop_addAnimation(scaleAnim, forKey: "scaleToDefaultAnimation")
    }
    
}
