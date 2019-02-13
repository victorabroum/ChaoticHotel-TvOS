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
    
    var entity: GKEntity!
    
    init(_ entity: GKEntity) {
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
        print("RoomerGiveUpState didEnter")
        
        // TODO: #06 Logic to lost some points
        
        self.stateMachine!.enter(RoomerGoOutState.self)
    }

}
