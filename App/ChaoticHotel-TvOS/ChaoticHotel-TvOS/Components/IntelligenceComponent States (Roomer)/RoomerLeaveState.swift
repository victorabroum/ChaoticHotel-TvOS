//
//  RoomerLeaveState.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class RoomerLeaveState: GKState {
    
    var entity: Roomer!
    
    init(_ entity: Roomer) {
        self.entity = entity
        super.init()
    }

   override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is RoomerListnerState.Type:
            return true
        default:
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        // TODO: SPAWN Bag on front of Room postion
        
        // Go to Reception
        guard let node = self.entity.component(ofType: RenderComponent.self)?.node else {
            return
        }
        
        guard let scene = node.scene as? GameScene else { return }
        
        let spawnPosition = scene.childNode(withName: "receptionPoint")?.position
        
        // Roomer go to Reception
        self.entity.walkTo(spawnPosition!, withDuration: 0) {
            
            // Available one Room
            scene.hotel.addAvailableRoom(self.entity.room)
            
            // Change to none room for the Roomer
            self.entity.changeRoom(nil)
            
            self.stateMachine?.enter(RoomerListnerState.self)
        }
        
    }

}
