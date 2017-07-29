//
//  ScoreArea.swift
//  BallBounce
//
//  Created by Scott Tyler on 7/26/17.
//  Copyright © 2017 Scott Tyler. All rights reserved.
//

import Foundation
import SpriteKit

class ScoreArea: SKSpriteNode {
    
    var changeScore: Int!
    
    func setValue(amount: Int) {
        changeScore = amount
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    } // end ovveride init()
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    } // end required init?()
    
} // end of class ScoreArea
