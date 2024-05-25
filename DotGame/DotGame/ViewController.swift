//
//  ViewController.swift
//  DotGame
//
//  Created by Elliot Boesch on 7/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    var timer : Timer?
    
    let topSpaceer: CGFloat = 40
    let bottomSpacer: CGFloat = 150
    let bottomTextSpacer: CGFloat = 90
    
    var score = 0
    var numLives = 5
    
    let actualScoreLabel = UILabel(), numOfLives = UILabel()
    var greenCircle = UIButton(), redCircle = UIButton(), orangeCircle = UIButton()
    
    let animateGreenCircle = Circle(howFast: 1)
    let animateRedCircle = Circle(howFast: 2)
    let animateOrangeCircle = Circle(howFast: 3)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "myTan")
        
        // MARK: MAIN TIMER
        
        timer = Timer.scheduledTimer(timeInterval: 1/100, target: self, selector: #selector(updateVals), userInfo: nil, repeats: true)
        timer?.fire()
        
        // MARK: BUTTONS

        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - bottomSpacer + topSpaceer))
        backButton.backgroundColor = UIColor(named: "myBlue")
        backButton.addTarget(self, action: #selector(decreaseLives), for: .touchDown)
        self.view.addSubview(backButton)
        
        // MARK: LABELS
        
        let scoreLabel = UILabel()
        formatLabel(label: scoreLabel, labelText: "Score: ", xPos: view.frame.size.width - (view.frame.size.width - 10))
        
        let livesLabel = UILabel()
        formatLabel(label: livesLabel, labelText: "Lives: ", xPos: view.frame.size.width - 230)
        
        formatLabel(label: actualScoreLabel, labelText: String (score), xPos: view.frame.size.width - (view.frame.size.width - 55))
        
        formatLabel(label: numOfLives, labelText: String (numLives), xPos: view.frame.size.width - 190)
        
        // MARK: Circles
        
        formatCircle(circle: greenCircle, circleColor: "myGreen")
        greenCircle.addTarget(self, action: #selector(increaseGreenCircleScore), for: .touchDown)
        
        formatCircle(circle: redCircle, circleColor: "myRed")
        redCircle.addTarget(self, action: #selector(increaseRedCircleScore), for: .touchDown)
        
        formatCircle(circle: orangeCircle, circleColor: "myOrange")
        orangeCircle.addTarget(self, action: #selector(increaseOrangeCircleScore), for: .touchDown)
    }
    
    // *** Function tied to the timer ***
    @objc func updateVals() {
        updateCircleValues() // Calculates new coordinates for each circle
        animateCircles() // Moves circles to new coordinates
        checkForEndAndScore() // Check score to see if reached new level & check number of lives to see if player has lost
    }
    
    @objc func decreaseLives() {
        numLives -= 1
        numOfLives.text = String (numLives)
    }
    @objc func increaseGreenCircleScore() {
        score += Int (animateGreenCircle.howFastValue)
        actualScoreLabel.text = String (score)
    }
    @objc func increaseRedCircleScore() {
        score += Int (animateRedCircle.howFastValue)
        actualScoreLabel.text = String (score)
    }
    @objc func increaseOrangeCircleScore() {
        score += Int (animateOrangeCircle.howFastValue)
        actualScoreLabel.text = String (score)
    }
    
    func updateCircleValues() {
        animateGreenCircle.completeMove()
        animateRedCircle.completeMove()
        animateOrangeCircle.completeMove()
    }
    
    func animateCircles() {
        greenCircle.frame = CGRect(x: animateGreenCircle.xPos, y: animateGreenCircle.yPos, width: 110, height: 110)
        redCircle.frame = CGRect(x: animateRedCircle.xPos, y: animateRedCircle.yPos, width: 110, height: 110)
        orangeCircle.frame = CGRect(x: animateOrangeCircle.xPos, y: animateOrangeCircle.yPos, width: 110, height: 110)
    }
    
    func checkForEndAndScore() {
        if (numLives == 0) {
            exit(0)
        }
        
        if (score >= 10) {
            animateGreenCircle.howFastValue = 2
            animateRedCircle.howFastValue = 3
            animateOrangeCircle.howFastValue = 4
        }
        
        if (score >= 20) {
            animateGreenCircle.howFastValue = 3
            animateRedCircle.howFastValue = 4
            animateOrangeCircle.howFastValue = 5
        }
    }
    
    func formatLabel(label: UILabel, labelText: String, xPos: CGFloat) {
        label.frame = CGRect(x: xPos, y: view.frame.size.height - bottomTextSpacer, width: 200, height: 40)
        label.text = labelText
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        
        self.view.addSubview(label)
    }
    
    func formatCircle(circle: UIButton, circleColor: String) {
        circle.frame = CGRect(x: 0, y: topSpaceer, width: 110, height: 110)
        circle.clipsToBounds = true
        circle.layer.cornerRadius = greenCircle.frame.size.height / 2
        circle.backgroundColor = UIColor(named: circleColor)
        circle.layer.masksToBounds = true
        
        self.view.addSubview(circle)
    }
}

