//
//  GameScene.swift
//  KnockOff
//
//  Created by Jeremy Taghizadeh on 7/21/15.
//  Copyright (c) 2015 Jeremy Taghizadeh. All rights reserved.
//
import UIKit
import SpriteKit
import Darwin
//

struct PhysicsCategory {
    static let None        : UInt32 = 0
    static let All         : UInt32 = UInt32.max
    static let User        : UInt32 = 0b1
    static let Enemy       : UInt32 = 0b10
    static let edge        : UInt32 = 0b100
    static let EnemyWeapon : UInt32 = 0b1000
    static let PowerUp     : UInt32 = 0b10000
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var _selectedNode: SKNode!
    var enemyShapes = EnemySpriteController()
    let powerUps = PowerUpController()
    var velocityController:CGFloat = 0.009
    var enemyVelocityController:CGFloat = 0.009 * 500
    var fireRate:CFTimeInterval = 4
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)

    }
    override func didMoveToView(view: SKView) {
     
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("handlePan:"))
        self.view?.addGestureRecognizer(gestureRecognizer)

        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        physicsWorld.contactDelegate = self
        createContent()
        
        
    }
// MARK: Create Content
    func createContent()
    {
        physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        physicsBody?.categoryBitMask = PhysicsCategory.edge
        physicsBody?.contactTestBitMask = PhysicsCategory.None
        
        setupUser()
        //SetupEnemy____________________
//        setupEnemies()
//        runAction(SKAction.repeatActionForever(
//            SKAction.sequence([
//                SKAction.runBlock(setupPowerUps),
//                SKAction.waitForDuration(2.0)
//                ])
//            ))
        //______________________________
        //setupPowerUps()
        addChild(enemyShapes.makeSprayer())
    }
    
// MARK: Setup user
    func setupUser()
    {
        let userShape = makeUser()
        self.addChild(userShape)
        
        
    }
    func makeUser()->SKShapeNode
    {
        let userShape = UserShape(rectOfSize: CGSize(width: 30, height: 30))
        userShape.position = CGPointMake(self.frame.size.width/2, userShape.frame.size.height/2)
        userShape.name = "userShape"
        userShape.fillColor = SKColor.blueColor()
        
        userShape.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 30, height: 30))
        
        userShape.physicsBody?.dynamic = true
        userShape.physicsBody?.affectedByGravity = false
        userShape.physicsBody?.mass = 0.02
        userShape.physicsBody?.friction = 0.0
        userShape.physicsBody?.restitution = 0.5
        userShape.physicsBody?.allowsRotation = false
        
        userShape.physicsBody?.categoryBitMask = PhysicsCategory.User;//Define collison variable
        userShape.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy | PhysicsCategory.EnemyWeapon;
        userShape.physicsBody?.collisionBitMask = PhysicsCategory.edge | PhysicsCategory.Enemy//collide with Edge
        
        return userShape
    }
    
// MARK: Setup enemy
    func setupEnemies()
    {
        for i in 1...3
        {
            self.addChild(enemyShapes.makeSwarmer())
            enemyShapes.enemyShapes.lastObject?.physicsBody!!.applyImpulse(CGVectorMake(random() * enemyVelocityController, random() * enemyVelocityController))
        }
        self.addChild(enemyShapes.makeBomber())
        enemyShapes.enemyShapes.lastObject?.physicsBody!!.applyImpulse(CGVectorMake(random() * enemyVelocityController, random() * enemyVelocityController))
    }
//MARK: Setup Powerups
    func setupPowerUps()
    {
        
        self.addChild(powerUps.makeHealthPowerUp())
        
    }
    
// MARK: UserShape Movement
    func selectNodeForTouch(touchLocation: CGPoint)//NODE SELECTOR
    {
        var touchedNode = nodeAtPoint(touchLocation)
        if (touchedNode.name == "userShape")
        {
            _selectedNode = touchedNode
            _selectedNode?.physicsBody?.velocity = CGVectorMake(0, 0)
        }
    
    }
    
    func panForTranslation(translation: CGPoint)//MOVES OBJECT TO WHERE YOU PLACE IT. CALLED IN handlePan()
    {
        if _selectedNode != nil
        {
            _selectedNode.physicsBody?.velocity = CGVectorMake(0, 0)
            var position = _selectedNode.position
            _selectedNode.position = CGPointMake(position.x + translation.x, position.y - translation.y)
        }
    }
    
    func handlePan(recognizer: UIPanGestureRecognizer!)
    {
        
        switch recognizer.state{
//        case .Began:
//            var touchLocation = recognizer.locationInView(recognizer.view!)
//            touchLocation = self.convertPointFromView(touchLocation)
//            selectNodeForTouch(touchLocation)
        case .Changed:
            var translation = recognizer.translationInView(recognizer.view!)
            translation = CGPointMake(translation.x, translation.y)
            
            self.panForTranslation(translation)
            recognizer.setTranslation(CGPointZero, inView: recognizer.view!)
        case .Ended:
            var velocity = recognizer.velocityInView(recognizer.view)
            if _selectedNode != nil{
                _selectedNode.physicsBody!.applyImpulse(CGVectorMake(velocity.x * velocityController, velocity.y * velocityController * -1.0))
            }
        default:
            break;
            
        }
        
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        let touch = touches.first as? UITouch
        var touchLocation = touch?.locationInView(self.view)
        touchLocation = self.convertPointFromView(touchLocation!)
        selectNodeForTouch(touchLocation!)
        
    }

//MARK: Update function
    
    var _swarmerLastShootTime: CFTimeInterval = 1
    var _bomberLastShootTime: CFTimeInterval = 1
    var _sprayerLastShootTime: CFTimeInterval = 1
    var _powerUpTime   : CFTimeInterval = 1
    
    
    override func update(currentTime: CFTimeInterval) {
        //SwarmerWeapon updates
        if currentTime - _swarmerLastShootTime >= fireRate
        {
            
            if let userShape = childNodeWithName("userShape")
            {
                    enemyShapes.swarmerShoot(userShape)
                    _swarmerLastShootTime = currentTime
            }
        }
        //BomberWeapon updates
        if currentTime - _bomberLastShootTime >= 2
        {
            
            if let userShape = childNodeWithName("userShape") as? UserShape
            {
                enemyShapes.bomberShoot(userShape)
                _bomberLastShootTime = currentTime
            }
        }
        //powerUp updates
        if currentTime - _powerUpTime >= 30 //SetupPowerUp. Creates a powerup at a random time interval between 30 sec to a minute
        {
            powerUps.makeHealthPowerUp()
            _powerUpTime = currentTime
        }
        
        if currentTime - _sprayerLastShootTime >= 2
        {
            
            if let userShape = childNodeWithName("userShape") as? UserShape
            {
                enemyShapes.sprayerShoot(userShape)
                _sprayerLastShootTime = currentTime
            }
        }
        
    }
    
    func didBeginContact(contact: SKPhysicsContact)
    {
        if (contact.bodyA.node?.name == "userShape")
        {
            //If a weapon comes into contact with the player-------------------------------
            if ((contact.bodyB.node?.name == "swarmerWeapon") || (contact.bodyB.node?.name == "bomberWeapon"))
            {
                contact.bodyB.node?.removeFromParent()
                if let userShape = contact.bodyA.node as? UserShape
                {
                    userShape.loseHealth(10)
                    if userShape.getHealth() <= 0
                    {
                        userShape.die()
                    }
                }
            }
            //------------------------------------------------------------------------------
            
            //If an enemy comes into contact with a player
            if (contact.bodyB.node?.name == "swarmer" || contact.bodyB.node?.name == "bomber")
            {
                
               if let enemyShape = contact.bodyB.node as? EnemyShape
               {
                    let damageTaken = calcVelocityOnImpact(nodeA: contact.bodyA.node!, nodeB: enemyShape) - 20
                    enemyShape.loseHealth(damageTaken)
                    if enemyShape.getHealth() <= 0
                    {
                        enemyShapes.removeEnemy(enemyShape)
                    }
                }
            }
            //------------------------------------------------------------------------------
            
            //If a powerUp comes into contact with plater
            if contact.bodyB.node?.name == "healthPowerUp"
            {
                contact.bodyB.node?.removeFromParent()
                if let userShape = contact.bodyA.node as? UserShape
                {
                    userShape.addHealth(20)
                }
            }
            //------------------------------------------------------------------------------
        }
    }
    
    func calcVelocityOnImpact(#nodeA:SKNode, nodeB:SKNode)-> CGFloat//Returns who was going faster. 0 for A, 1 for B
    {
        
        if let nodeAdx = nodeA.physicsBody?.velocity.dx, let nodeAdy = nodeA.physicsBody?.velocity.dy, let nodeBdx = nodeB.physicsBody?.velocity.dx,let nodeBdy = nodeB.physicsBody?.velocity.dy
        {
            var nodeAdxSquared = nodeAdx * nodeAdx
            var nodeAdySquared = nodeAdy * nodeAdy
            //var nodeBdxSquared = nodeBdx * nodeBdx
            //var nodeBdySquared = nodeBdy * nodeBdy
            
            var nodeAVelocity = sqrt(nodeAdxSquared + nodeAdySquared)
            //var nodeBVelocity = sqrt(nodeBdxSquared + nodeBdySquared) / 2
            
            return nodeAVelocity
        }
        
        return 0.0
        
    }
    //MARK: Random Functions
    func random() -> CGFloat
    {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(#min: CGFloat, max: CGFloat) -> CGFloat
    {
        return random() * (max-min) + min
    }
    
}









