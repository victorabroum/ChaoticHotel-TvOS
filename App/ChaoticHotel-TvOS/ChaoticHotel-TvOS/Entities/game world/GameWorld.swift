//
//  GameWorld.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 18/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class GameWorld: GKEntity {
    // Into GameWorld has a Hotel
    var hotelEntity: Hotel
    var scene: GameScene
    
    init(scene: GameScene) {
        self.scene = scene
        let receptionPoint = self.scene.childNode(withName: "receptionPoint")!.position
        let avaibaleRooms = self.scene.childNode(withName: "rooms")!
        self.hotelEntity = Hotel(availableRooms: avaibaleRooms.children, receptionPoint: receptionPoint)
        super.init()
        
        // Add GameWorld to EntityManager
        self.scene.entityManager.add(self)
        
        // Add Hotel to EntityManager
        self.scene.entityManager.add(self.hotelEntity)
        
        // Set ContactDelegate
        self.scene.physicsWorld.contactDelegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
