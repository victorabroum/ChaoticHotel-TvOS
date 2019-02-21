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
        
        guard let node = self.entity.component(ofType: RenderComponent.self)?.node else { return }
        
        guard let scene = node.scene as? GameScene else { return }
        
        self.entity.wantLeave = true
        
        // Roomer leave the room
        scene.gameWorld.hotelEntity.addAvailableRoom(self.entity.room)
        
        // Change to none room for the Roomer
        self.entity.changeRoom(nil)
        
        self.stateMachine?.enter(RoomerListnerState.self)
    }

}
