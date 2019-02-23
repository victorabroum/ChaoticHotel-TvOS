//
//  Goop.swift
//  ChaoticHotel-TvOS
//
//  Created by Renato Lopes on 15/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import GameplayKit
import SpriteKit

class Goop: AssistEntity {
    var stateMachine: GKStateMachine!
    
    init(withImage image: String, parentNode: SKSpriteNode) {
        super.init()
        
        self.assistDelegate = self
        
        let renderComponent = RenderComponent.init(imageNamed: image)
        renderComponent.node.entity = self
        // TODO: JUST FOR TESTS
        renderComponent.node.position = parentNode.position
        renderComponent.node.position.y -= parentNode.size.height / 2 - 40
        renderComponent.node.xScale = 0.25
        renderComponent.node.yScale = 0.25
        
        let ballonComponent = BallonComponent.init(nodeSuper: renderComponent.node, andTexture: nil)
        self.addComponent(renderComponent)
        self.addComponent(ballonComponent)
        self.prepateStateMachine()
        
        // ADD Physics
        let physicsComp = PhysicsBoydComponent(node: renderComponent.node, categoryMask: CategoryMask.interaction)
        physicsComp.physicBody.contactTestBitMask =
            ~(CategoryMask.contactWithAllCategories())
        physicsComp.physicBody.collisionBitMask =
            ~(CategoryMask.contactWithAllCategories())
        self.addComponent(physicsComp)
        
        // ADD Service
        let serviceComp = ServiceComponent(owner: self, serviceCategory: .clean)
        self.addComponent(serviceComp)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
