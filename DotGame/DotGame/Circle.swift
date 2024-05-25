//
//  Circle.swift
//  DotGame
//
//  Created by Elliot Boesch on 7/11/22.
//

import Foundation
import UIKit


class Circle {
    var xPos: CGFloat = 0
    var yPos: CGFloat = 40
    
    var topEdge: Bool = true
    var leftEdge: Bool = false
    var rightEdge: Bool = false
    var bottomEdge: Bool = false
    
    let screenSize: CGRect
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    
    var howFastValue: CGFloat
    
    init(howFast: CGFloat) {
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        howFastValue = howFast
    }
    
    func checkEdges() {
        if yPos <= 40 {
            topEdge = true
            bottomEdge = false
        }
        
        if yPos >= screenHeight - 150 - 70 {
            topEdge = false
            bottomEdge = true
        }
        
        if xPos <= 0 {
            leftEdge = true
            rightEdge = false
        }
        
        if xPos >= screenWidth - 110 {
            leftEdge = false
            rightEdge = true
        }
    }
    
    func moveCircle() {
        if topEdge {
            yPos += howFastValue
        }
        
        if bottomEdge {
            yPos -= howFastValue
        }
        
        if leftEdge {
            xPos += howFastValue
        }
        
        if rightEdge {
            xPos -= howFastValue
        }
    }
    
    func completeMove(){
        checkEdges()
        moveCircle()
    }
    
}
