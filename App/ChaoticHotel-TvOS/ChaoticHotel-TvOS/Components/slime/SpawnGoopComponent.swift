//
//  SpawnComponent.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 21/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class SpawnGoopComponent: GKComponent {
    var spawnArea: SKNode
    var entityManager: EntityManager
    var oldDeltaTimer: TimeInterval = 0
    
    init(spawnArea: SKNode, entityManager: EntityManager) {
        self.spawnArea = spawnArea
        self.entityManager = entityManager
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SpawnGoopComponent {
    override func update(deltaTime seconds: TimeInterval) {
        
        self.oldDeltaTimer += seconds
        if self.oldDeltaTimer >= WaitTimer.spwanGoop {
            print("SLIME TRY SHOOT GOOP")
            
            guard let slimeNode = self.entity?.component(ofType: RenderComponent.self)?.node else { return }
            
            if ((Int.random(in: 0...10) >= 0) && self.spawnArea.contains(slimeNode.position)) {
                self.entityManager.spawnGoop(onParentNode: slimeNode)
            }
            
            self.oldDeltaTimer = 0.0
        }
    }
}
