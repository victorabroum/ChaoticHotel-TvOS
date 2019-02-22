//
//  Slime.swift
//  ChaoticHotel-TvOS
//
//  Created by Renato Lopes on 14/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import SpriteKit
import GameplayKit

class Slime: GKEntity {
    var stateMachine: GKStateMachine!
    var oldDeltaTimer: TimeInterval = 0.0
    var entityManager: EntityManager
    
    init(withImageNamed name: String, entityManager: EntityManager, possibleSpawnArea: SKNode) {
        self.entityManager = entityManager
        super.init()
        // Created instance components
        let renderComponent = RenderComponent.init(imageNamed: "\(name)_idle_01")
        renderComponent.node.zPosition = ZPosition.slime
        let moveComponent = MoveComponent(maxSpeed: 5)
        
        // Add components to Entity
        self.addComponent(moveComponent)
        self.addComponent(renderComponent)
        
        // Add Spawn Goop Component
        let spawnGoopComp = SpawnGoopComponent(spawnArea: possibleSpawnArea, entityManager: self.entityManager)
        self.addComponent(spawnGoopComp)
        
        self.prepareStateMachine()
        
        // Add Animation Comp
        let animateComp = AnimationComponent(texturesAtlasName: "\(name)")
        animateComp.nodeToAnimate = renderComponent.node
        animateComp.animateNode(withState: .idle)
        self.addComponent(animateComp)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
