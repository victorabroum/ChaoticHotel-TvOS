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
    
    func changeWaitingFor(_ wait: ServiceCategory!) {
        self.waitingFor = wait
    }
    
    func changeRoom(_ room: SKNode!) {
        self.room = room
    }
    
    func deliverService(ofCategory category: ServiceCategory) {
        if (category == self.waitingFor) {
            print("Roomer - Thank you, pick a Tip")
            self.stateMachine.enter(RoomerAssistState.self)
        } else {
            print("Wrong Service Baby")
        }
    }
}
