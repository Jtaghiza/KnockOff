//
//  PowerUps.swift
//  KnockOff
//
//  Created by Jeremy Taghizadeh on 8/11/15.
//  Copyright (c) 2015 Jeremy Taghizadeh. All rights reserved.
//

import SpriteKit
import Foundation

class PowerUps: SKShapeNode
{
    
    override init()
    {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func die()
    {
        self.removeAllChildren()
        self.removeFromParent()
    }
    
}