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
    
    var entity: Roomer!
    
    init(_ entity: Roomer) {
        self.entity = entity
        super.init()
    }

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
    
    override func willExit(to nextState: GKState) {
        guard let node = self.entity.component(ofType: RenderComponent.self)?.node else {
            return
        }
        node.removeAllActions()
    }
    
    override func didEnter(from previousState: GKState?) {
        var waitTimer: TimeInterval = WaitTimer.reception
        var textureName: String?
        var waitingFor: WaitingFor = .checkIn
        
        // TODO: Put right textureName
        if(previousState != nil) {
            switch previousState! {
            case is RoomerListnerState:
                // Wait a time and Go Out
                print("Wait a time and Go Out")
                waitTimer = WaitTimer.bag
                textureName = nil
                waitingFor = .bag
                
                // TODO: Put on right place
                // It is just for test in here
                self.stateMachine?.enter(RoomerGoOutState.self)
            case is RoomerRoomState:
                // Wait a time on room for bag
                print("Wait a time on room for bag")
                waitTimer = WaitTimer.bag
                textureName = nil
                waitingFor = .bag
            case is RoomerRoomServiceState:
                // Wait a time on room for Room service
                print("Wait a time on room for Room service")
                waitTimer = WaitTimer.roomService
                textureName = nil
                waitingFor = .food
            case is RoomerLeaveState:
                // Wait a time on reception
                // Go to RoomerListnerState
                print("Wait a time on reception")
                waitTimer = WaitTimer.reception
                textureName = nil
                waitingFor = .checkOut
                
                // TODO: Put on right place
                // It is just for test in here
                self.stateMachine?.enter(RoomerListnerState.self)
            default:
                break
            }
        }
        
        self.entity.changeWaitingFor(waitingFor)
        
        // Test
        // If the Roomer is Assisted
        guard let node = self.entity.component(ofType: RenderComponent.self)?.node else {
            return
        }
        // After 3 seconds the Roomer is assisted
        node.run(SKAction.wait(forDuration: 3)) {
            self.stateMachine?.enter(RoomerAssistState.self)
        }
        
        // End Test
        self.animate(imageNamed: textureName, duration: waitTimer)
    }
    
    func animate(imageNamed: String?, duration: TimeInterval) {
        
        guard let node = self.entity.component(ofType: RenderComponent.self)?.node else {
            return
        }
        
        guard let ballon = self.entity.component(ofType: BallonComponent.self) else {return}
        
        if (imageNamed != nil) {
            ballon.changeTexture(forTexture: SKTexture(imageNamed: imageNamed!))
        }
        
        ballon.showBallon()
        
        let idleWait = SKAction.wait(forDuration: duration)
        
        node.run(idleWait) {
            node.removeAllActions()
            ballon.dismissBallon()
            self.stateMachine?.enter(RoomerGiveUpState.self)
        }
    }
}
