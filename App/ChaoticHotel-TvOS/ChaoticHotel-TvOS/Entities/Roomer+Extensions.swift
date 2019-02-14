//
//  Roomer+Extensions.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

extension Roomer {
    
    func prepareStateMachine() {
        self.stateMachine = GKStateMachine(states: [
            RoomerListnerState(self),
            RoomerGiveUpState(self),
            RoomerAssistState(self),
            RoomerRoomState(self),
            RoomerWaitState(self),
            RoomerRoomServiceState(self),
            RoomerLeaveState(self),
            RoomerGoOutState(self)
            ])
    }
    
    func walkTo(_ point: CGPoint) {
        guard let moveComp = self.component(ofType: MoveComponent.self) else {
            return
        }
        
        moveComp.move(to: point) {
            print("Enter on First state")
            self.stateMachine.enter(RoomerListnerState.self)
        }
    }
}
