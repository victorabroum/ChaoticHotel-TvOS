//
//  Roomer.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class Roomer: AssistEntity {
    
    var stateMachine: GKStateMachine!
    
    // Flag to track if Entity is in Room
    var isInRoom: Bool = false
    
    var wantLeave: Bool = false
    
    // To track what room Roomer is allocated
    var room: SKNode! = nil
    
    init(withImageNamed imageNamed: String, inPosition position: CGPoint) {
        super.init()
        
        // Preapre State Machine
        self.prepareStateMachine()
        
        // Service Delegate
        self.assistDelegate = self
        
        // Add RenderComponent
        let renderComponent = RenderComponent(imageNamed: imageNamed)
        renderComponent.node.position = position
        renderComponent.node.entity = self
        self.addComponent(renderComponent)
        
        // Add BallonComponent for show icons
        let ballonComponent = BallonComponent.init(nodeSuper: renderComponent.node, andTexture: nil)
        
        self.addComponent(ballonComponent)
        self.addComponent(MoveComponent(maxSpeed: Float.random(in: 5...9)))
        
        // Add Physics Body
        let physicsBodyComponent = PhysicsBoydComponent(node: renderComponent.node, categoryMask: CategoryMask.roomer)
        
        // Roomer don't contact nobody
        physicsBodyComponent.physicBody.contactTestBitMask =
            ~(CategoryMask.contactWithAllCategory())
        
        // Roomer don't collide nobody
        physicsBodyComponent.physicBody.collisionBitMask =
            ~(CategoryMask.contactWithAllCategory())
        
        self.addComponent(physicsBodyComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("ME QUEBREI")
    }
}
