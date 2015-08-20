//
//  enemyShape.swift
//  KnockOff
//
//  Created by Jeremy Taghizadeh on 8/5/15.
//  Copyright (c) 2015 Jeremy Taghizadeh. All rights reserved.
//

import SpriteKit

class EnemyShape: SKShapeNode {
    var unitHealth: CGFloat
    override init()
    {
        unitHealth = 100
        super.init()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func loseHealth(damageTaken:CGFloat)
    {
        if(damageTaken >= 0 )
        {
            unitHealth -= damageTaken
        }
    }
    func die()
    {
        self.removeAllChildren()
        self.removeFromParent()
    }
    func getHealth()-> CGFloat
    {
        return unitHealth
    }
    
}