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
    
    init(node: SKSpriteNode, categoryMask: CategoryMask) {
        self.node = node
        super.init()
        
        // ADD PhysicsBody
        self.node.physicsBody = SKPhysicsBody(circleOfRadius: self.node.size.width/2)
        // Default is not affected by gravity
        self.node.physicsBody?.affectedByGravity = false
        // Default is not rotate
        self.node.physicsBody?.allowsRotation = false
        // Default is not Dynamic
        self.node.physicsBody?.isDynamic = false
        
        self.node.physicsBody?.categoryBitMask = categoryMask.rawValue
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
