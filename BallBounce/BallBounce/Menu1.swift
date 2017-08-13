//
//  Menu1.swift
//  BallBounce
//
//  Created by Scott Tyler on 8/2/17.
//  Copyright © 2017 Scott Tyler. All rights reserved.
//

import Foundation
import SpriteKit

enum selectedLevel{
    case one, two, three, four, five, six, seven, eight, nine, ten
}

var currentStage: String = ""

class Menu1: SKScene {
    
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
    var back: MSButtonNode!
    var start: MSButtonNode!
    let world: String = "1"
    var chosenLevel = ""
    var buttonArray = [MSButtonNode]()
    
    override func didMove(to view: SKView) {
        // set code connections for buttons here
        stage1 = childNode(withName: "1") as! MSButtonNode
        stage2 = childNode(withName: "2") as! MSButtonNode
        stage3 = childNode(withName: "3") as! MSButtonNode
        stage4 = childNode(withName: "4") as! MSButtonNode
        stage5 = childNode(withName: "5") as! MSButtonNode
        stage6 = childNode(withName: "6") as! MSButtonNode
        stage7 = childNode(withName: "7") as! MSButtonNode
        stage8 = childNode(withName: "8") as! MSButtonNode
        stage9 = childNode(withName: "9") as! MSButtonNode
        stage10 = childNode(withName: "10") as! MSButtonNode
        previousWorld = childNode(withName: "previousWorld") as! MSButtonNode
        nextWorld = childNode(withName: "nextWorld") as! MSButtonNode
        back = childNode(withName: "back") as! MSButtonNode
        start = childNode(withName: "start") as! MSButtonNode
        setButtonArray()
        for button in buttonArray {
            print(1)
            button.selectedHandler = { [unowned self] in
                self.chosenLevel = button.name!
                
           //     self.view?.presentScene(GameScene(fileNamed: "GameScene"))
                //self.loadLevel(lvl: self.chosenLevel)
                print(self.chosenLevel)
            }
        }
        start.selectedHandler = { [unowned self] in
            self.loadLevel(lvl: self.chosenLevel)
        }
    }
    
    /*  func buttonSelect(name: String) -> String {
     
     let selectedLevel = ""
     return selectedLevel
     // possible to use the components String func to get the level select from world and button names
     } */
    
    
    // function to make add all the level buttons into an array for use later in the start button code
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
   //     if chosenLevel != "1" { // remove this later, only for testing
   //         chosenLevel = "1" // remove this later, only for testing
   //     }
        
        print("Level_\(lvl)")
        currentStage = "Level_\(lvl)"
        
        guard let scene = GameScene(fileNamed: "Level_\(lvl)") else {
            print("Could not load GameScene with level \(chosenLevel)")
            return
        }
        
        /* 3) Ensure correct aspect mode */
        scene.scaleMode = .aspectFit
        
        /* Show debug */
        skView.showsPhysics = true
        skView.showsDrawCount = true
        skView.showsFPS = true
        
        /* 4) Start game scene */
        skView.presentScene(scene)
    }
    
}
