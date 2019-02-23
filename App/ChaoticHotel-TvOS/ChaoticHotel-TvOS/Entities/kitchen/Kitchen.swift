//
//  Kitchen.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 19/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class Kitchen: InteractEntity {
    
    override init() {
        super.init()
        
        self.interactDelegate = self
        
        // Add render
        let renderComp = RenderComponent(imageNamed: "")
        renderComp.node = SKSpriteNode(
            texture: nil,
            color: .clear,
            size: CGSize(width: 250, height: 250)
        )
        renderComp.node.alpha = 0.75
        renderComp.node.entity = self
        self.addComponent(renderComp)
        
        // Add Physicsc
        let physicsComp = PhysicsBoydComponent(
            node: renderComp.node,
            categoryMask: CategoryMask.interaction
        )
        // Don't collide and contact with nobody
        physicsComp.physicBody.collisionBitMask =
            ~(CategoryMask.contactWithAllCategories())
        physicsComp.physicBody.contactTestBitMask =
            ~(CategoryMask.contactWithAllCategories())
        self.addComponent(physicsComp)
        
        // Add Interaction
        let interactionComp = InteractionComponent()
        self.addComponent(interactionComp)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
