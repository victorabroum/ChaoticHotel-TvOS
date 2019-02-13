//
//  RoomerListnerState.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class RoomerListnerState: GKState {

   override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is RoomerListnerState.Type:
            return true
        case is RoomerAssistState.Type:
            return true
        case is RoomerGiveUpState.Type:
            return true
        case is RoomerGoOutState.Type:
            return true
        default:
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        
        if(previousState != nil) {
            switch previousState! {
            case is RoomerListnerState:
                // Wait a time and Go Out
                break
            case is RoomerRoomState:
                // Wait a time on room for bag
                break
            case is RoomerRoomServiceState:
                // Wait a time on room for Room service
                break
            case is RoomerLeaveState:
                // Wait a time on reception
                // Go to RoomerListnerState
                break
            default:
                break
            }
        }
        
    }

}
