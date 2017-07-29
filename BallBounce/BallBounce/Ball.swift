//
//  Ball.swift
//  BallBounce
//
//  Created by Scott Tyler on 7/25/17.
//  Copyright © 2017 Scott Tyler. All rights reserved.
//

import Foundation
import SpriteKit

class Ball: SKSpriteNode {
    
    /* You are required to implement this for your subclass to work */
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    } // end ovveride init()
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    } // end required init?()
} // end of class Ball
