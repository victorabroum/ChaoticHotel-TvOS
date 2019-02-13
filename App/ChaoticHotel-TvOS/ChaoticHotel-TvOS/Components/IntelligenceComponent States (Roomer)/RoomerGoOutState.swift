//
//  RoomerGoOutState.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class RoomerGoOutState: GKState {

   override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        default:
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        
    }

}
