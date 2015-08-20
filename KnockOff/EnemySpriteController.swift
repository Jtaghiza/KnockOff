//
//  EnemySpriteController.swift
//  KnockOff
//
//  Created by Jeremy Taghizadeh on 8/7/15.
//  Copyright (c) 2015 Jeremy Taghizadeh. All rights reserved.
//

import SpriteKit

class EnemySpriteController {
    //var enemyShapes: [EnemyShape] = []
    var enemyShapes = NSMutableArray()
    
    func makeSwarmer()->SKShapeNode
    {
        var screen = UIScreen.mainScreen().applicationFrame;
        let newSwarmer = EnemyShape(rectOfSize: CGSize(width: 30, height: 30))
        enemyShapes.addObject(newSwarmer)
        
        let enemyXSpawnPoint = random(min: newSwarmer.frame.size.width/2, max: screen.size.width - newSwarmer.frame.size.width/2)
        
        newSwarmer.position = CGPointMake(enemyXSpawnPoint, screen.size.height - newSwarmer.frame.size.height/2)
        newSwarmer.name = "swarmer"
        newSwarmer.fillColor = SKColor.redColor()
        
        
        newSwarmer.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 30, height: 30))
        
        newSwarmer.physicsBody?.dynamic = true
        newSwarmer.physicsBody?.affectedByGravity = false
        newSwarmer.physicsBody?.mass = 0.02
        newSwarmer.physicsBody?.friction = 0.0
        newSwarmer.physicsBody?.restitution = 1.0
        newSwarmer.physicsBody?.allowsRotation = false
        
        newSwarmer.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        newSwarmer.physicsBody?.contactTestBitMask = PhysicsCategory.User
        newSwarmer.physicsBody?.collisionBitMask = PhysicsCategory.edge | PhysicsCategory.User
        
        
        return newSwarmer
    }
    func swarmerShoot(targetSprite: SKNode) {
        
        for enemy in enemyShapes {
           if enemy.name == "swarmer"
           {
                // Create the bullet sprite
                let bullet = SKSpriteNode()
                bullet.color = UIColor.greenColor()
                bullet.size = CGSize(width: 5,height: 5)
                bullet.position = CGPointMake(enemy.position.x, enemy.position.y)
                bullet.name = "swarmerWeapon"
                targetSprite.parent?.addChild(bullet)
                
                bullet.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 5, height: 5))
                
                bullet.physicsBody?.affectedByGravity = false
                bullet.physicsBody?.categoryBitMask = PhysicsCategory.EnemyWeapon
                bullet.physicsBody?.contactTestBitMask = PhysicsCategory.User
                bullet.physicsBody?.collisionBitMask = PhysicsCategory.None
                
                // Determine vector to targetSprite
                let vector = CGVectorMake((targetSprite.position.x-enemy.position.x), targetSprite.position.y-enemy.position.y)
                
                // Create the action to move the bullet. Don't forget to remove the bullet!
                let bulletAction = SKAction.sequence([
                    SKAction.repeatAction(SKAction.moveBy(vector, duration: 3), count: 10),
                    SKAction.waitForDuration(30.0/60.0),
                    SKAction.removeFromParent()
                    ])
                bullet.runAction(bulletAction)
            }
        }
    }
    func makeBomber()->SKShapeNode
    {
        var screen = UIScreen.mainScreen().applicationFrame;
        let newBomber = EnemyShape(rectOfSize: CGSize(width: 50, height: 50))
        enemyShapes.addObject(newBomber)
        
        let enemyXSpawnPoint = random(min: newBomber.frame.size.width/2, max: screen.size.width - newBomber.frame.size.width/2)
        
        newBomber.position = CGPointMake(enemyXSpawnPoint, screen.size.height - newBomber.frame.size.height/2)
        newBomber.name = "bomber"
        newBomber.fillColor = SKColor.redColor()
        
        
        newBomber.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 50, height: 50))
        
        newBomber.physicsBody?.dynamic = true
        newBomber.physicsBody?.affectedByGravity = false
        newBomber.physicsBody?.mass = 0.02
        newBomber.physicsBody?.friction = 0.0
        newBomber.physicsBody?.restitution = 1.0
        newBomber.physicsBody?.allowsRotation = false
        
        newBomber.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        newBomber.physicsBody?.contactTestBitMask = PhysicsCategory.User
        newBomber.physicsBody?.collisionBitMask = PhysicsCategory.edge | PhysicsCategory.User
        
        
        return newBomber
    }
    func bomberShoot(targetSprite: SKNode) {
        
        for enemy in enemyShapes {
            if enemy.name == "bomber"{
                // Create the bullet sprite
                let bomb = SKSpriteNode()
                bomb.color = UIColor.yellowColor()
                bomb.size = CGSize(width: 10,height: 10)
                bomb.position = CGPointMake(enemy.position.x, enemy.position.y)
                bomb.name = "bomberWeapon"
                targetSprite.parent?.addChild(bomb)
                
                bomb.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 10, height: 10))
                
                bomb.physicsBody?.affectedByGravity = false
                bomb.physicsBody?.categoryBitMask = PhysicsCategory.EnemyWeapon
                bomb.physicsBody?.contactTestBitMask = PhysicsCategory.User
                bomb.physicsBody?.collisionBitMask = PhysicsCategory.None
                
                let bombAction = SKAction.sequence([
                    //SKAction.repeatAction(SKAction.moveBy(vector, duration: 3), count: 10),
                    SKAction.waitForDuration(5),
                    SKAction.removeFromParent()
                    ])
                bomb.runAction(bombAction)
            }
        }
    }
    func makeSprayer()->SKShapeNode
    {
        var screen = UIScreen.mainScreen().applicationFrame;
        let newSprayer = EnemyShape(rectOfSize: CGSize(width: 25, height: 25))
        enemyShapes.addObject(newSprayer)
        
        let xSpawnPoint = random(min: newSprayer.frame.size.width/2, max: screen.size.width - newSprayer.frame.size.width/2)
        let ySpawnPoint = random(min: newSprayer.frame.size.height/2, max: screen.size.height - newSprayer.frame.size.height/2)
        
        newSprayer.position = CGPointMake(xSpawnPoint, screen.size.height - newSprayer.frame.size.height/2)
        newSprayer.name = "sprayer"
        newSprayer.fillColor = SKColor.grayColor()
        
        
        newSprayer.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 25, height: 25))
        
        newSprayer.physicsBody?.dynamic = true
        newSprayer.physicsBody?.affectedByGravity = false
        newSprayer.physicsBody?.mass = 0.02
        newSprayer.physicsBody?.friction = 0.0
        newSprayer.physicsBody?.restitution = 1.0
        newSprayer.physicsBody?.allowsRotation = false
        
        newSprayer.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        newSprayer.physicsBody?.contactTestBitMask = PhysicsCategory.User
        newSprayer.physicsBody?.collisionBitMask = PhysicsCategory.edge | PhysicsCategory.User
        
        
        return newSprayer
    }
    func sprayerShoot(targetSprite: SKNode) {
        
        for enemy in enemyShapes {
            if enemy.name == "sprayer"
            {
                // Create the bullet sprite
                var bullets:[SKSpriteNode] = []//creates 8 bullets
                //var bullet = SKSpriteNode()
                for i in 0...7
                {
                    var index = i
                    var newBullet = SKSpriteNode()
                    bullets.append(newBullet)
                }
                

                for i in 0...7
                {
                    
                    bullets[i] = SKSpriteNode()
                    bullets[i].color = UIColor.greenColor()
                    bullets[i].size = CGSize(width: 5,height: 5)
                    bullets[i].position = CGPointMake(enemy.position.x, enemy.position.y)
                    bullets[i].name = "sprayerWeapon"
                    targetSprite.parent?.addChild(bullets[i])
                    
                    bullets[i].physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 5, height: 5))
                    
                    bullets[i].physicsBody?.affectedByGravity = false
                    bullets[i].physicsBody?.categoryBitMask = PhysicsCategory.EnemyWeapon
                    bullets[i].physicsBody?.contactTestBitMask = PhysicsCategory.User
                    bullets[i].physicsBody?.collisionBitMask = PhysicsCategory.None
                    
                }
//                bullets[0].physicsBody?.applyForce(CGVectorMake(0, -5))
//                bullets[1].physicsBody?.applyForce(CGVectorMake(-5, 0))
//                bullets[2].physicsBody?.applyForce(CGVectorMake(5,  0))
//                bullets[3].physicsBody?.applyForce(CGVectorMake(0,  5))

                
                //bullets[0].physicsBody?.applyForce(CGVectorMake(0, 10))
//                bullet.color = UIColor.greenColor()
//                bullet.size = CGSize(width: 5,height: 5)
//                bullet.position = CGPointMake(enemy.position.x, enemy.position.y)
//                bullet.name = "sprayerWeapon"
//                targetSprite.parent?.addChild(bullet)
//                
//                bullet.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 5, height: 5))
//                
//                bullet.physicsBody?.affectedByGravity = false
//                bullet.physicsBody?.categoryBitMask = PhysicsCategory.EnemyWeapon
//                bullet.physicsBody?.contactTestBitMask = PhysicsCategory.User
//                bullet.physicsBody?.collisionBitMask = PhysicsCategory.None
//                
//                bullet.physicsBody?.applyForce(CGVectorMake(0, -10))
                
                // Determine vector to targetSprite
                //let vector = CGVectorMake((targetSprite.position.x-enemy.position.x), targetSprite.position.y-enemy.position.y)
                
                // Create the action to move the bullet. Don't forget to remove the bullet!
            }
        }
    }

    func removeEnemy(enemyShape: EnemyShape)
    {
        enemyShape.die()
        enemyShapes.removeObject(enemyShape)
    }
    
    func random() -> CGFloat
    {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(#min: CGFloat, max: CGFloat) -> CGFloat
    {
        return random() * (max-min) + min
    }
}
