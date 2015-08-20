//
//  PowerUpController.swift
//  KnockOff
//
//  Created by Jeremy Taghizadeh on 8/11/15.
//  Copyright (c) 2015 Jeremy Taghizadeh. All rights reserved.
//

import Foundation
import SpriteKit

class PowerUpController {
    //var enemyShapes: [EnemyShape] = []
    var powerUps = NSMutableArray()
    
    func makeHealthPowerUp()->SKShapeNode
    {
        var screen = UIScreen.mainScreen().applicationFrame;
        let newPowerup = PowerUps(rectOfSize: CGSize(width: 10, height: 10))
        powerUps.addObject(newPowerup)
        
        let xSpawnPoint = random(min: newPowerup.frame.size.width/2, max: screen.size.width - newPowerup.frame.size.width/2)
        let ySpawnPoint = random(min: newPowerup.frame.size.height/2, max: screen.size.height - newPowerup.frame.size.height/2)
            
        newPowerup.position = CGPointMake(xSpawnPoint, ySpawnPoint)
        newPowerup.name = "healthPowerUp"
        newPowerup.fillColor = SKColor.greenColor()
        
        
        newPowerup.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 10, height: 10))
        
        newPowerup.physicsBody?.dynamic = true
        newPowerup.physicsBody?.affectedByGravity = false
        newPowerup.physicsBody?.mass = 0.02
        newPowerup.physicsBody?.friction = 0.0
        newPowerup.physicsBody?.restitution = 1.0
        newPowerup.physicsBody?.allowsRotation = false
        
        newPowerup.physicsBody?.categoryBitMask = PhysicsCategory.PowerUp
        newPowerup.physicsBody?.contactTestBitMask = PhysicsCategory.User
        newPowerup.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        
        return newPowerup
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