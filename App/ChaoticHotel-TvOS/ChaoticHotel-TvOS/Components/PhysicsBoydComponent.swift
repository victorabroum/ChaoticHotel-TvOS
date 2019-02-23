//
//  PhysicsBoydComponent.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 18/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class PhysicsBoydComponent: GKComponent {
    
    var node: SKSpriteNode!
    var physicBody: SKPhysicsBody!
    
    init(node: SKSpriteNode, categoryMask: UInt32) {
        self.node = node
        super.init()
        
        // ADD PhysicsBody
        self.physicBody = SKPhysicsBody(rectangleOf: self.node.size)
//        self.physicBody = SKPhysicsBody(circleOfRadius: self.node.size.width/2)
        
        // Default is not affected by gravity
        self.physicBody.affectedByGravity = false
        // Default is not rotate
        self.physicBody.allowsRotation = false
        
        self.physicBody.categoryBitMask = categoryMask
        
        self.node.physicsBody = self.physicBody
        
    }
    
    init(node: SKSpriteNode,
         categoryMask: UInt32,
         physicBody: SKPhysicsBody) {
        self.node = node
        super.init()
        
        // ADD PhysicsBody
        self.physicBody = physicBody
        
        // Default is not affected by gravity
        self.physicBody.affectedByGravity = false
        // Default is not rotate
        self.physicBody.allowsRotation = false
        
        self.physicBody.categoryBitMask = categoryMask
        
        self.node.physicsBody = self.physicBody
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
