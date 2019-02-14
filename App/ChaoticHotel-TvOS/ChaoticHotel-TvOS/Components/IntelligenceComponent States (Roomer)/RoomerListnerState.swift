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
    
    override func didEnter(from previousState: GKState?) {
        var waitTimer: TimeInterval = WaitTimer.reception
        var waitTextureBallon: SKTexture?
        var textureName: String?
        
        if(previousState != nil) {
            switch previousState! {
            case is RoomerListnerState:
                // Wait a time and Go Out
                print("Wait a time and Go Out")
                waitTimer = WaitTimer.bag
                textureName = nil
            case is RoomerRoomState:
                // Wait a time on room for bag
                print("Wait a time on room for bag")
                waitTimer = WaitTimer.bag
                textureName = nil
            case is RoomerRoomServiceState:
                // Wait a time on room for Room service
                print("Wait a time on room for Room service")
                waitTimer = WaitTimer.roomService
                textureName = nil
            case is RoomerLeaveState:
                // Wait a time on reception
                // Go to RoomerListnerState
                print("Wait a time on reception")
                waitTimer = WaitTimer.reception
                textureName = nil
            default:
                break
            }
        }
        
        guard let node = self.entity.component(ofType: RenderComponent.self)?.node else {
            return
        }
        
        guard let ballon = self.entity.component(ofType: BallonComponent.self) else {return}
        
        if let texture = textureName {
            waitTextureBallon = SKTexture.init(
                imageNamed: texture)
            ballon.changeTexture(forTexture: waitTextureBallon)
        }
        ballon.showBallon()

        let idleWait = SKAction.wait(forDuration: waitTimer)
        
        node.run(idleWait) {
            node.removeAllActions()
            ballon.dismissBallon()
            self.stateMachine?.enter(RoomerGiveUpState.self)
        }
    }
}
