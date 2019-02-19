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
            RoomerArriveState(self),
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
    
    func walkTo(_ point: CGPoint,
                withDuration duration: TimeInterval = 0,
                withCompletion completion: (() -> Void)? = nil) {
        guard let moveComp = self.component(ofType: MoveComponent.self) else {
            return
        }
        
        moveComp.move(to: point, withDuration: duration) {
            if (completion != nil) {
                completion!()
            }
        }
    }
    
    func changeRoom(_ room: SKNode!) {
        self.room = room
    }
}

extension Roomer: AssistDelegate {
    func assisted() {
        self.stateMachine.enter(RoomerAssistState.self)
    }
}
