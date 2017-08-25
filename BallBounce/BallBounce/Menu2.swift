//
//  Menu1.swift
//  BallBounce
//
//  Created by Scott Tyler on 8/2/17.
//  Copyright © 2017 Scott Tyler. All rights reserved.
//

import Foundation
import SpriteKit

//enum levelLockState {
//    case locked, unlocked
//}

class Menu2: SKScene {
    
    // all buttons declared here.
    
    var stage1: MSButtonNode!
    var stage2: MSButtonNode!
    var stage3: MSButtonNode!
    var stage4: MSButtonNode!
    var stage5: MSButtonNode!
    var stage6: MSButtonNode!
    var stage7: MSButtonNode!
    var stage8: MSButtonNode!
    var stage9: MSButtonNode!
    var stage10: MSButtonNode!
    var previousWorld: MSButtonNode!
    var nextWorld: MSButtonNode!
    var creditsButton: MSButtonNode!
    var startButton: MSButtonNode!
    var buttonArray = [MSButtonNode]()
    var targetScoreLabel: SKLabelNode! // will change based on selected level
    var highScoreLabel: SKLabelNode! // will change based on selected level
    //  var lockedState: levelLockState = .locked
    //  var targetScoreDict: Dictionary[String, Int]()
    
    override func didMove(to view: SKView) {
        // set code connections for buttons here
        stage1 = childNode(withName: "11") as! MSButtonNode
        stage2 = childNode(withName: "12") as! MSButtonNode
        stage3 = childNode(withName: "13") as! MSButtonNode
        stage4 = childNode(withName: "14") as! MSButtonNode
        stage5 = childNode(withName: "15") as! MSButtonNode
        stage6 = childNode(withName: "16") as! MSButtonNode
        stage7 = childNode(withName: "17") as! MSButtonNode
        stage8 = childNode(withName: "18") as! MSButtonNode
        stage9 = childNode(withName: "19") as! MSButtonNode
        stage10 = childNode(withName: "20") as! MSButtonNode
        previousWorld = childNode(withName: "previousWorld") as! MSButtonNode
        nextWorld = childNode(withName: "nextWorld") as! MSButtonNode
        targetScoreLabel = childNode(withName: "targetScoreLabel") as! SKLabelNode
        highScoreLabel = childNode(withName: "highScoreLabel") as!  SKLabelNode
        creditsButton = childNode(withName: "creditsButton") as! MSButtonNode
        startButton = childNode(withName: "startButton") as! MSButtonNode
        setButtonArray()
        for button in buttonArray {
            button.selectedHandler = { [unowned self] in
                currentStage = "Level_\(button.name!)"
                let highScore = defaults.integer(forKey: currentStage)
                self.highScoreLabel.text = String(highScore) // set highScoreLabel to that of selected level
            }
        } // end array of level buttons
        startButton.selectedHandler = { [unowned self] in
            if currentStage != "" {
                self.loadLevel(lvl: currentStage)
            }
        }
        creditsButton.selectedHandler = { [unowned self] in
            self.loadScene(lvl: "Credits")
        }
        
        nextWorld.selectedHandler = { [unowned self] in
            currentWorld += 1
            self.loadScene(lvl: "Menu2")
        }
        
        previousWorld.selectedHandler = { [unowned self] in
            currentWorld -= 1
            self.loadScene(lvl: "Menu1")
        }
    }
    
    // function to add all the level buttons into an array for use later in the start button code
    func setButtonArray() {
        buttonArray.append(stage1)
        buttonArray.append(stage2)
        buttonArray.append(stage3)
        buttonArray.append(stage4)
        buttonArray.append(stage5)
        buttonArray.append(stage6)
        buttonArray.append(stage7)
        buttonArray.append(stage8)
        buttonArray.append(stage9)
        buttonArray.append(stage10)
    }
    
    func loadLevel(lvl:String) {
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView! else {
            print("Could not get Skview")
            return
        }
        /* 2) Load Game scene */
        guard let scene = GameScene(fileNamed: lvl) else {
            print("Could not load GameScene with Level \(lvl)")
            return
        }
        
        /* 3) Ensure correct aspect mode */
        scene.scaleMode = .aspectFit
        /* Show debug */
        skView.showsPhysics = false
        skView.showsDrawCount = false
        skView.showsFPS = false
        print(currentStage)
        /* 4) Start game scene */
        skView.presentScene(scene)
    }
    
    func loadScene(lvl:String) {
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView! else {
            print("Could not get Skview")
            return
        }
        /* 2) Load Game scene */
        // currentStage = lvl
        
        guard let scene = SKScene(fileNamed: lvl) else {
            print("Could not load GameScene with Level \(lvl)")
            return
        }
        
        /* 3) Ensure correct aspect mode */
        scene.scaleMode = .aspectFit
        /* Show debug */
        skView.showsPhysics = false
        skView.showsDrawCount = false
        skView.showsFPS = false
        /* 4) Start game scene */
        skView.presentScene(scene)
    }
}
