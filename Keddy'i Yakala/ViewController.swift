//
//  ViewController.swift
//  Keddy'i Yakala
//
//  Created by Barış KIR on 21.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    //    variables
    
    var score = 0
    var timer = Timer()
    var counter = 0
    
    var keddyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    //    views
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var cat1: UIImageView!
    @IBOutlet weak var cat2: UIImageView!
    @IBOutlet weak var cat3: UIImageView!
    @IBOutlet weak var cat4: UIImageView!
    @IBOutlet weak var cat5: UIImageView!
    @IBOutlet weak var cat6: UIImageView!
    @IBOutlet weak var cat7: UIImageView!
    @IBOutlet weak var cat8: UIImageView!
    @IBOutlet weak var cat9: UIImageView!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        
        if storedHighScore == nil{
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
            
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        
        scoreLabel.text = "Score: \(score)"
        
        //        images
        
        cat1.isUserInteractionEnabled = true
        cat2.isUserInteractionEnabled = true
        cat3.isUserInteractionEnabled = true
        cat4.isUserInteractionEnabled = true
        cat5.isUserInteractionEnabled = true
        cat6.isUserInteractionEnabled = true
        cat7.isUserInteractionEnabled = true
        cat8.isUserInteractionEnabled = true
        cat9.isUserInteractionEnabled = true
        
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        
        cat1.addGestureRecognizer(recognizer1)
        cat2.addGestureRecognizer(recognizer2)
        cat3.addGestureRecognizer(recognizer3)
        cat4.addGestureRecognizer(recognizer4)
        cat5.addGestureRecognizer(recognizer5)
        cat6.addGestureRecognizer(recognizer6)
        cat7.addGestureRecognizer(recognizer7)
        cat8.addGestureRecognizer(recognizer8)
        cat9.addGestureRecognizer(recognizer9)
        
        keddyArray = [cat1, cat2, cat3, cat4, cat5, cat6, cat7, cat8, cat9]
        
        
        //        timer
        
        counter = 10
        timeLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKeddy), userInfo: nil, repeats: true)
        hideKeddy()
        
    }
    
    
    @objc func hideKeddy() {
        for keddy in keddyArray{
            keddy.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(keddyArray.count - 1)))
        keddyArray[random].isHidden = false
        
        
        
    }
    
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = "\(counter)"
        
            if counter == 0{
                timer.invalidate()
                hideTimer.invalidate()
                
                for keddy in keddyArray{
                    keddy.isHidden = true
                }
                
//                highScore
                
                if self.score > self.highScore{
                    highScore = self.score
                    highScoreLabel.text = "Highscore: \(self.highScore)"
                    UserDefaults.standard.set(self.highScore, forKey: "highScore")
                }
                
                
//                Alert
                let alert = UIAlertController(title: "Times is Up!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
                let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) {
                    (UIAlertAction) in
//        replay func
                    
                    self.score = 0
                    self.scoreLabel.text = "Score: \(self.score)"
                    self.counter = 10
                    self.scoreLabel.text = "\(self.counter)"
                    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                    self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKeddy), userInfo: nil, repeats: true)
                    
                    
                }
                alert.addAction(okButton)
                alert.addAction(replayButton)
                self.present(alert, animated: true)
                
            }
            
    }


}

