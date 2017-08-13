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

/* Control the game state
    playing is when the game is runing in a level.
    gameOver is when a level is completed
    menu is when the user is not in a game level.
*/
enum GameState {
    case playing, gameOver, menu
}
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ballLayer: SKNode!
    var ball1: Ball! // remove this later, will become ball spawn point
    var ballArray: [Ball] = []
    var motionManager: CMMotionManager!
    var ballLimit: Int = 50 // eventually this will change based on which lelvel is loaded
    var score: Int = 0 // start at zero for each level, eventually will store hi-score for each level
    var scoreLabel: SKLabelNode!
    var scoreUp: ScoreArea! //    these are for testing. eventually replace with an array
    var scoreDown: ScoreArea! //  of ScoreArea to be populated based on the level
    var obstacle: Obstacle! // will eventually change this to an array obstacles
    var obstacleArray: [Obstacle] = []
    let fixedDelta: CFTimeInterval = 1.0 / 60.0 /* 60 FPS */
    var spawnTimer: CFTimeInterval = 0
    var gameState: GameState = .playing
    var restartButton: MSButtonNode!
    var backButton: MSButtonNode!
    
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
        obstacle = childNode(withName: "obstacle") as! Obstacle
        scoreLabel = childNode(withName: "scoreLabel") as! SKLabelNode
        physicsWorld.contactDelegate = self
        restartButton = childNode(withName: "restartButton") as! MSButtonNode
        restartButton.selectedHandler = { [unowned self] in // adding this in the selection handler curbs a memory leak
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            /* Load Game scene */
            let scene = GameScene(fileNamed:currentStage) as GameScene!
            /* Ensure correct aspect mode */
            scene?.scaleMode = .aspectFill
            /* Restart game scene */
            skView?.presentScene(scene)
        }
        backButton = childNode(withName: "backButton") as! MSButtonNode
        backButton.selectedHandler = { [unowned self] in
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            /* Load Game scene */
            let scene = GameScene(fileNamed:"Menu1") as GameScene!
            /* Ensure correct aspect mode */
            scene?.scaleMode = .aspectFill
            /* Restart game scene */
            skView?.presentScene(scene)
        }
    } // end of didMove
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    } // end of touchesBegan
    
    override func update(_ currentTime: TimeInterval) {
        
        for ball in ballArray {
            if let data = motionManager.accelerometerData {
                ball.position.x += CGFloat(Double((data.acceleration.x)) * 20)
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
            
            let newPosition = CGPoint(x: 165, y: 570)
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
        
        if ( type(of: nodeA) == Obstacle.self && type(of: nodeB) == Ball.self ) || ( type(of: nodeA) == Ball.self && type(of: nodeB) == Obstacle.self ) {
            if type(of: nodeA) == Ball.self {
                nodeA.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 1.7))
                return
            }
         else { // this may be hitting the outer if statement. make into an else if
            nodeB.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 1.7))
            return
            }
        }
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
    
    /* Make a Class method to load levels */
    class func level(_ levelNumber: Int) -> GameScene? {
        guard let scene = GameScene(fileNamed: "Level_\(levelNumber)") else {
            return nil
        }
        scene.scaleMode = .aspectFit
        return scene
    }// end of class func level()

} // end of GameScene
