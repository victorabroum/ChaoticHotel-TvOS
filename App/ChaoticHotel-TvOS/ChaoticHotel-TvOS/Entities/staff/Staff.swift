//
//  Staff.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class Starff: GKEntity {
    
    var service: ServiceCategory = .listen
    
    var holdItem: Items!
    
    init(withImageNamed imageNamed: String) {
        super.init()
        
        // Add RenderComponent
        let renderComponent = RenderComponent(imageNamed: "\(imageNamed)_starff_idle_01")
        
        renderComponent.node.entity = self
        renderComponent.node.zPosition = ZPosition.starff
        
        self.addComponent(renderComponent)
       
        // Add MoveComponent
        self.addComponent(MoveComponent(maxSpeed: Float(PlayerConstants.normal)))
        
        // Add PhysicsBodyComponent
        let physicsBodyComponent = PhysicsBoydComponent(node: renderComponent.node, categoryMask: CategoryMask.starff)
        
        // Staff contact with all Entity less him self
        physicsBodyComponent.physicBody.contactTestBitMask =
            CategoryMask.contactWithAllCategories(less: [CategoryMask.starff])
        
        // Staff don't collide with nobody
        physicsBodyComponent.physicBody.collisionBitMask =
            ~(CategoryMask.contactWithAllCategories(
                less: [CategoryMask.walls]))
        
        self.addComponent(physicsBodyComponent)
        
        let animationComp = AnimationComponent(texturesAtlasName: "\(imageNamed)_starff")
        animationComp.nodeToAnimate = renderComponent.node
        animationComp.animateNode(withState: .idle)
        self.addComponent(animationComp)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
