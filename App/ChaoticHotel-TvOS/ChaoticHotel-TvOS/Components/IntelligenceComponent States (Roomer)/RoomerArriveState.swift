//
//  RoomerArriveState.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 15/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class RoomerArriveState: GKState {

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
        // Find the Hotel
        guard let node = self.entity.component(ofType: RenderComponent.self)?.node else { return }
        guard let scene = node.scene as? GameScene else { return }
        
        scene.gameWorld.hotelEntity.enterOnQueue(self.entity) {
            self.entity.stateMachine.enter(RoomerListnerState.self)
        }
    }

}
