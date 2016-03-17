//
//  ViewController.swift
//  BrainTeaser
//
//  Created by Shivam Kapur on 15/03/16.
//  Copyright © 2016 Shivam Kapur. All rights reserved.
//

import UIKit
import pop

class LoginVC: UIViewController {

  
    @IBOutlet var loginButtonConstraint: NSLayoutConstraint!
    @IBOutlet var passwordConstraint: NSLayoutConstraint!
    @IBOutlet var usernameConstraint: NSLayoutConstraint!
    
    var animEngine:AnimationEngine!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animEngine = AnimationEngine(constraints: [loginButtonConstraint,passwordConstraint,usernameConstraint])
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        animEngine.animateScreen(1)
    }
    
}

