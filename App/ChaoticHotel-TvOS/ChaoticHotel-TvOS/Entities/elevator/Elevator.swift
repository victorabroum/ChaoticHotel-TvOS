//
//  Elevator.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 18/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

enum ElevatorDirection {
    case upper
    case down
}

class Elevator: InteractEntity {
    var goTo: ElevatorDirection
    var transport: GKEntity!
    
    init(goTo: ElevatorDirection) {
        self.goTo = goTo
        super.init()
        
        // Add RenderComponent
        let renderComponent = RenderComponent(imageNamed: "")
        renderComponent.node = SKSpriteNode(texture: nil, color: .gray, size: CGSize(width: 135, height: 50))
        renderComponent.node?.entity = self
        self.addComponent(renderComponent)
        
        // Add Physic component
        let physicsComponent = PhysicsBoydComponent(node: renderComponent.node!, categoryMask: .reception)
        
        physicsComponent.physicBody.collisionBitMask =
            ~(CategoryMask.contactWithAllCategory())
        physicsComponent.physicBody.contactTestBitMask =
            ~(CategoryMask.contactWithAllCategory())
        
        self.addComponent(physicsComponent)
        
        // ADD Interaction Component
        let interactComp = InteractionComponent()
        self.addComponent(interactComp)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
