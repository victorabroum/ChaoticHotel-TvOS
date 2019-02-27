//
//  RoomerWaitState.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import UIKit
import GameplayKit

class RoomerWaitState: GKState {
    
    var entity: Roomer!
    
    init(_ entity: Roomer) {
        self.entity = entity
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is RoomerRoomServiceState.Type:
            return true
        case is RoomerLeaveState.Type:
            return true
        default:
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        
        guard let node = self.entity.component(ofType: RenderComponent.self)?.node else { return }
        
        node.run(SKAction.wait(forDuration: TimeInterval.random(in: 2...5))) {
            // Has 60% of chance to ask for Room Service
            if (Int.random(in: 0...10) >= 3) {
                node.run(
                    SKAction.playSoundFileNamed("roomService_voice", waitForCompletion: false))
                self.stateMachine?.enter(RoomerRoomServiceState.self)
            } else {
                node.run(
                    SKAction.playSoundFileNamed("checkOut_voice", waitForCompletion: false))
                self.stateMachine?.enter(RoomerLeaveState.self)
            }
        }
    }

}
