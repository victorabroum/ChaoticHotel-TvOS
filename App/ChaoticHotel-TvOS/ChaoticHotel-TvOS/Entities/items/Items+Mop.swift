//
//  Items+Mop.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 23/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class Mop: Items {
    init() {
        super.init(
            imageNamed: "mop",
            serviceCategory: .clean,
            isHold: false,
            categoryMask: CategoryMask.items,
            lifeTime: -1,
            rotation: CGFloat.pi/2)
        
        guard let node = self.component(ofType: RenderComponent.self)?.node else { return }
        
        node.zRotation = 0
        
        self.removeComponent(ofType: PhysicsBoydComponent.self)
        
        let physicsBody = SKPhysicsBody(texture: node.texture!, size: node.size)
        let physicsComp = PhysicsBoydComponent(
            node: node,
            categoryMask: CategoryMask.items,
            physicBody: physicsBody)
        
        physicsComp.physicBody.affectedByGravity = true
        physicsComp.physicBody.allowsRotation = true
        physicsComp.physicBody?.contactTestBitMask = ~(CategoryMask.contactWithAllCategories())
        
        physicsComp.physicBody?.collisionBitMask = ~(CategoryMask.contactWithAllCategories(less: [CategoryMask.floor]))
        
        self.physicsBodyComp = physicsComp
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
