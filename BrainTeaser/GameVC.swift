//
//  GameVC.swift
//  BrainTeaser
//
//  Created by Shivam Kapur on 16/03/16.
//  Copyright © 2016 Shivam Kapur. All rights reserved.
//

import UIKit
import pop

class GameVC: UIViewController {

    @IBOutlet weak var titleLbl:UILabel!
    @IBOutlet weak var noBtn:CustomButton!
    @IBOutlet weak var yesBtn:CustomButton!
    @IBOutlet weak var timerLbl:UILabel!
    
    var currentCard:Card!

    var timer:NSTimer!
    
    var animEngine:AnimationEngine!
    
    var timeCounter:Int = 60
    
    var correctAnswerCount:Int = 0
    
    var incorrectAnswerCount:Int = 0
    
    var currentImageName:String = ""
    
    var previousImageName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentCard = loadCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        self.view.addSubview(currentCard)
        
        timer = NSTimer()
        
    }
    
    func countdown() {
        
        if timeCounter == 0 {
            timer.invalidate()
            yesBtn.hidden = true
            noBtn.hidden = true
            let alert = UIAlertController(title: "Game Completed.", message: "Your Score: Correct Guesses: \(correctAnswerCount) Incorrect Guesses: \(incorrectAnswerCount)", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Restart Game", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                self.yesBtn.hidden = false
                self.noBtn.hidden = false
                self.timeCounter = 60
                self.createTimer()
            })
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        timerLbl.text = "\(timeCounter--)"
    }
    
    @IBAction func noBtnTapped(sender:AnyObject) {
        showNextCard()
        checkAnswer()
    }
    
    @IBAction func yesBtnTapped(sender:UIButton) {
        if sender.titleLabel!.text == "START" {
            sender.setTitle("YES", forState: .Normal)
            noBtn.hidden = false
            titleLbl.text = "Does this image match the previous one?"
            createTimer()
        }
        
        
        showNextCard()
        checkAnswer()
    }
    
    func showNextCard() {
        if let current = currentCard {
            let cardToRemove = current
            previousImageName = cardToRemove.currentImage
            currentCard = nil
            
            AnimationEngine.animateCard(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { animation,finished in
                    cardToRemove.removeFromSuperview()
            })
        }
        
        if let next = loadCardFromNib() {
            currentCard = next
            next.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(next)
            currentImageName = next.currentImage

            AnimationEngine.animateCard(next, position: AnimationEngine.screenCenterPosition, completion: { animation,finished in
                
            })
        }
        
    }
    
    func checkAnswer() {
        if timer.valid {
            if currentImageName == previousImageName {
                correctAnswerCount++
            }
            else {
                incorrectAnswerCount++
            }
        }
    }
    
    func createTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countdown", userInfo: nil, repeats: true)
    }
    
    
    func loadCardFromNib() -> Card? {
        return NSBundle.mainBundle().loadNibNamed("Card", owner: self, options: nil)[0] as? Card
    }

}
