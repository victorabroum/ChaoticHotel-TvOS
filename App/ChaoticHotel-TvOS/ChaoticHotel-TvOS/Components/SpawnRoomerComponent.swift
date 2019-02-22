//
//  SpawnComponent.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 21/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class SpawnRoomerComponent: GKComponent {
    var lastSpawn: TimeInterval = 0.0
    var entityManager: EntityManager
    var spawnPoint: CGPoint
    
    init(entityManager: EntityManager, onPoint spawn: CGPoint) {
        self.entityManager = entityManager
        self.spawnPoint = spawn
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// SpawnSystem
extension SpawnRoomerComponent {
    override func update(deltaTime seconds: TimeInterval) {
        let spawnRoomerInterval = TimeInterval(15)
        if (CACurrentMediaTime() - lastSpawn > spawnRoomerInterval) {
            lastSpawn = CACurrentMediaTime()
            let roomer = Roomer(
                withImageNamed: ListOfRoomers.assests.randomElement()!,
                inPosition: self.spawnPoint)
            self.entityManager.spawnRoomer(ofType: roomer)
        }
    }
}
