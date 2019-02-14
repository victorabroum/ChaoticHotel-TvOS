//
//  RoomerAssistState.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class RoomerAssistState: GKState {
    
    var entity: Roomer!
    
    init(_ entity: Roomer) {
        self.entity = entity
        super.init()
    }

   override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is RoomerRoomState.Type:
            return true
        case is RoomerWaitState.Type:
            return true
        case is RoomerListnerState.Type:
            return true
        default:
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        print("RoomerAssistState didEnter")
        
        guard let ballonNode = self.entity.component(ofType: BallonComponent.self) else { return }
        
        ballonNode.dismissBallon()
        
        print("WAITING FOR \(self.entity.waitingFor!)")
        
        if (self.entity.waitingFor == .checkOut) {
            self.stateMachine?.enter(RoomerListnerState.self)
        } else if self.entity.isInRoom {
            self.stateMachine?.enter(RoomerWaitState.self)
        } else {
            self.entity.isInRoom  = true
            self.stateMachine?.enter(RoomerRoomState.self)
        }
    }

}
