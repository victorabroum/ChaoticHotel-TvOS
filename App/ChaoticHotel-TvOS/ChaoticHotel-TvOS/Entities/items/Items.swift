//
//  Items.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 19/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class Items: InteractEntity {
    var serviceCategory: ServiceCategory
    var isHold: Bool = false
    var physicsBodyComp: PhysicsBoydComponent!
    
    init(imageNamed: String,
         serviceCategory: ServiceCategory,
         isHold: Bool = false,
         categoryMask: CategoryMask,
         lifeTime: TimeInterval = 20) {
        
        self.serviceCategory = serviceCategory
        super.init()
        
        self.interactDelegate = self
        
        // ADD Render
        let renderComp = RenderComponent(imageNamed: imageNamed)
        renderComp.node.entity = self
        renderComp.node.zPosition = ZPosition.items
        self.addComponent(renderComp)
        
        // ADD Physics Body
        let physicsComp = PhysicsBoydComponent(
            node: renderComp.node,
            categoryMask: categoryMask,
            physicBody: SKPhysicsBody(rectangleOf: renderComp.node.size))
        physicsComp.physicBody.contactTestBitMask =
            ~(CategoryMask.contactWithAllCategory())
        physicsComp.physicBody.collisionBitMask =
            ~(CategoryMask.contactWithAllCategory())
        self.physicsBodyComp = physicsComp
        self.addComponent(physicsComp)
        
        // ADD Life Time
        // -1 Interval means infinity lifetime
        if (lifeTime != -1) {
            let lifeComp = LifeTimeComponent(lifeDuration: lifeTime)
            self.addComponent(lifeComp)
        } else {
            print("TEMPO INFINITO")
        }
        
        // ADD Interction
        let interaction = InteractionComponent()
        self.addComponent(interaction)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
