//
//  GameScene.swift
//  BallBounce
//
//  Created by Scott Tyler on 7/24/17.
//  Copyright © 2017 Scott Tyler. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ballLayer: SKNode!
    var ball1: Ball!
    var ball2: Ball!
    var ballArray: [Ball] = []
    var motionManager: CMMotionManager!
    var ballLimit: Int = 50
    var score: Int = 0
    var scoreLabel: SKLabelNode!
    var scoreUp: ScoreArea!
    var scoreDown: ScoreArea!
    var testObstacle: Obstacle!
    let fixedDelta: CFTimeInterval = 1.0 / 60.0 /* 60 FPS */
    var spawnTimer: CFTimeInterval = 0
    
    override func didMove(to view: SKView) {
        
        // lets set up our code connections for the game
        ballLayer = childNode(withName: "ballLayer")!
        ball1 = childNode(withName: "//ball1") as! Ball //will eventually get rid of this
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        scoreUp = childNode(withName: "scoreUp") as! ScoreArea
        scoreUp.setValue(amount: 50)
        scoreDown = childNode(withName: "scoreDown") as! ScoreArea
        scoreDown.setValue(amount: -50)
        testObstacle = childNode(withName: "testObstacle") as! Obstacle
        scoreLabel = childNode(withName: "scoreLabel") as! SKLabelNode
        physicsWorld.contactDelegate = self
    } // end of didMove
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    } // end of touchesBegan
    
    override func update(_ currentTime: TimeInterval) {
        
        for ball in ballArray {
            if let data = motionManager.accelerometerData {
                ball.position.x += CGFloat(Double((data.acceleration.x)) * 20)
      //          ball.position.y += CGFloat(Double((data.acceleration.y)) * 10)
                if ball.position.y < -20 {
                    ball.removeFromParent()
                }
            }
        }
        if let data = motionManager.accelerometerData {
             ball1.position.x += CGFloat(Double((data.acceleration.x)) * 20)
             ball1.position.y += CGFloat(Double((data.acceleration.y)) * 10)
        }
     
        if ballArray.count <= ballLimit {
            spawnBalls()
            spawnTimer += fixedDelta
        }
    } // end of update
    
    func spawnBalls() {
        if spawnTimer >= 0.4 {
            let newBall = ball1.copy() as! Ball
            ballLayer.addChild(newBall)
            
            let newPosition = CGPoint(x: 165, y: 560)
            newBall.position = self.convert(newPosition, to: ballLayer)
            ballArray.append(newBall)
            spawnTimer = 0
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        /* Ensure only called while game running */
   //     if gameState != .playing { return }
        
        /* Get references to bodies involved in collision */
        let contactA = contact.bodyA
        let contactB = contact.bodyB
        /* Get references to the physics body parent nodes */
        let nodeA = contactA.node!
        let nodeB = contactB.node!
        
   /*     if ( type(of: nodeA) == Obstacle.self && type(of: nodeB) == Ball.self ) || ( type(of: nodeA) == Ball.self && type(of: nodeB) == Obstacle.self ) {
            if type(of: nodeA) == Ball.self {
                nodeA.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 1000))
            }
        } else {
            nodeB.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 1000))
        } */
        
        // code that checks if a ball comes in contact with  a scoreArea
        if ( type(of: nodeA) == Ball.self &&  nodeB.name == "scoreUp" ) || ( nodeA.name == "scoreUp" && type(of: nodeB) == Ball.self ){
            /* Increment score */
           score += scoreUp.changeScore
            /* Update score label */
            scoreLabel.text = String(score)
            /* We can return now */
            if type(of: nodeA) == Ball.self {
        //        score += nodeB.changeScore
                nodeA.removeFromParent()
            } else {
                nodeB.removeFromParent()
            }
            return
        } else if ( type(of: nodeA) == Ball.self &&  nodeB.name == "scoreDown" ) || ( nodeA.name == "scoreDown" && type(of: nodeB) == Ball.self ){
            /* Increment score */
            score += scoreDown.changeScore
            /* Update score label */
            scoreLabel.text = String(score)
            /* We can return now */
            if type(of: nodeA) == Ball.self {
                nodeA.removeFromParent()
            } else {
                nodeB.removeFromParent()
            }
            return
        } else {
            return
        }
    } // end of didBegin

} // end of GameScene
