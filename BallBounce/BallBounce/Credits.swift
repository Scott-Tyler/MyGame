//
//  Credits.swift
//  BallBounce
//
//  Created by Scott Tyler on 8/23/17.
//  Copyright © 2017 Scott Tyler. All rights reserved.
//

import Foundation
import SpriteKit

class Credits: SKScene {
    
    var backButton: MSButtonNode!
    
    override func didMove(to View: SKView) {
        backButton = childNode(withName: "backButton") as! MSButtonNode
        
        backButton.selectedHandler = { [unowned self] in
            print(1)
            guard let skView = self.view as SKView! else {
                print("Could not get Skview")
                return
            }
            /* 2) Load Game scene */
            // currentStage = lvl
            let lvl = "Menu\(currentWorld)"
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
}
