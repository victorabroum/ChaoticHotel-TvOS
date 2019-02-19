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
        
        // TODO: Review the renderComp
        // I think it's need to be alpha = 0
        
        // Add render
        let renderComp = RenderComponent(imageNamed: "")
        renderComp.node = SKSpriteNode(
            texture: nil,
            color: .purple,
            size: CGSize(width: 250, height: 250)
        )
        renderComp.node?.alpha = 0.75
        renderComp.node?.entity = self
        self.addComponent(renderComp)
        
        // Add Physicsc
        let physicsComp = PhysicsBoydComponent(
            node: renderComp.node!,
            categoryMask: .reception
        )
        // Don't collide and contact with nobody
        physicsComp.physicBody.collisionBitMask =
            ~(CategoryMask.contactWithAllCategory())
        physicsComp.physicBody.contactTestBitMask =
            ~(CategoryMask.contactWithAllCategory())
        self.addComponent(physicsComp)
        
        // Add Interaction
        let interactionComp = InteractionComponent()
        self.addComponent(interactionComp)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
