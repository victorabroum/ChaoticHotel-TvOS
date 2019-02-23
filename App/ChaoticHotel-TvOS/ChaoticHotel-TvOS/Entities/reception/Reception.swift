//
//  Reception.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 18/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class Reception: InteractEntity {
    var hotel: Hotel
    
    init (hotel: Hotel) {
        self.hotel = hotel
        super.init()
        
        self.interactDelegate = self
        
        // Add RenderComponent
        let renderComponent = RenderComponent(imageNamed: "")
        renderComponent.node = SKSpriteNode(texture: nil, color: .clear, size: CGSize(width: 135, height: 135))
        renderComponent.node.entity = self
        self.addComponent(renderComponent)
        
        // Add Physic component
        let physicsComponent = PhysicsBoydComponent(node: renderComponent.node, categoryMask: CategoryMask.interaction)
        
        physicsComponent.physicBody.collisionBitMask =
            ~(CategoryMask.contactWithAllCategories())
        physicsComponent.physicBody.contactTestBitMask =
            ~(CategoryMask.contactWithAllCategories())
        
        self.addComponent(physicsComponent)
        
        // ADD Interaction Component
        let interactComp = InteractionComponent()
        self.addComponent(interactComp)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
