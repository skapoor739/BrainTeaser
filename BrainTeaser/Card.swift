//
//  Card.swift
//  BrainTeaser
//
//  Created by Shivam Kapur on 16/03/16.
//  Copyright © 2016 Shivam Kapur. All rights reserved.
//

import UIKit

@IBDesignable
class Card: UIView {

    @IBOutlet var imageView: UIImageView!
    
    let imageArray = ["shape1","shape2","shape3"]
    
    var currentImage:String!
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setImage()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
        setImage()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.cornerRadius
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5.0
        self.layer.shadowColor = UIColor(red: 157.0/255.0, green: 157.0/255.0, blue: 157.0/255.0, alpha: 1.0).CGColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    }
    
    func setImage() {
        let teaserImage = imageArray[Int(arc4random_uniform(3))]
        currentImage = teaserImage
        imageView.image = UIImage(named: teaserImage)
    }
   
}
