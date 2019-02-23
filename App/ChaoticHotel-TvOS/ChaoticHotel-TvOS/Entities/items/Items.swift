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
    var rotation: CGFloat!
    
    init(imageNamed: String,
         serviceCategory: ServiceCategory,
         isHold: Bool = false,
         categoryMask: UInt32,
         lifeTime: TimeInterval = 20,
         rotation: CGFloat? = nil) {
        
        self.rotation = rotation
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
            affectedByGravity: true)
        physicsComp.physicBody.contactTestBitMask =
            ~(CategoryMask.contactWithAllCategories())
        physicsComp.physicBody.collisionBitMask =
            ~(CategoryMask.contactWithAllCategories(less: [CategoryMask.floor]))
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
