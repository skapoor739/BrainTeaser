//
//  AnimationEngine.swift
//  BrainTeaser
//
//  Created by Shivam Kapur on 16/03/16.
//  Copyright © 2016 Shivam Kapur. All rights reserved.
//

import Foundation
import UIKit
import pop

class AnimationEngine {
    
    class var offScreenLeftPosition:CGPoint {
        return CGPointMake(-UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    class var offScreenRightPosition:CGPoint {
        return CGPointMake(UIScreen.mainScreen().bounds.width,CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    class var screenCenterPosition:CGPoint {
        return CGPointMake(CGRectGetMidX(UIScreen.mainScreen().bounds), CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    var originalConstants = [CGFloat]()
    var constraints = [NSLayoutConstraint]()
    
    init(constraints: [NSLayoutConstraint]) {
        
        for con in constraints {
            originalConstants.append(con.constant)
            con.constant = AnimationEngine.offScreenRightPosition.x
        }
        
        self.constraints = constraints
    }
    
    func animateScreen(delay:Int64) {
        var index = 0
        var time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(delay) * Double(NSEC_PER_SEC)))
        
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            repeat {
                let springAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
                springAnim.toValue = self.originalConstants[index]
                springAnim.springBounciness = 12
                springAnim.springSpeed = 12
                
                let con = self.constraints[index]
                con.pop_addAnimation(springAnim, forKey: "ConstraintLayerAnimation")
                index++
            } while (index < self.constraints.count)
        }
    }
    
    class func animateCard(view:UIView, position:CGPoint, completion: ((POPAnimation!, Bool) -> Void)!) {
        let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
        moveAnim.toValue = NSValue(CGPoint: position)
        moveAnim.springBounciness = 8
        moveAnim.springSpeed = 8
        moveAnim.completionBlock = completion
        view.pop_addAnimation(moveAnim, forKey: "moveAnimation")
    }
    
}