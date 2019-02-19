//
//  RoomerGiveUpState.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class RoomerGiveUpState: GKState {
    
    var entity: Roomer!
    
    init(_ entity: Roomer) {
        self.entity = entity
        super.init()
    }

   override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is RoomerGoOutState.Type:
            return true
        default:
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        
        // TODO: #06 Logic to lost some points
        
        // Go to Reception
        guard let node = self.entity.component(ofType: RenderComponent.self)?.node else {
            return
        }
        
        guard let scene = node.scene as? GameScene else { return }
        
        if (self.entity.room != nil) {
            scene.hotel.addAvailableRoom(self.entity.room)
        }
        
        if (!self.entity.isInRoom) {
            scene.hotel.exitQueue()
        }
        
        // TODO: Feedback Roomer is angry
        print("QUE HOTEL MERDA")
        node.run(SKAction.scale(by: 0.5, duration: 0.5)) {
            self.stateMachine!.enter(RoomerGoOutState.self)
        }
    }

}
