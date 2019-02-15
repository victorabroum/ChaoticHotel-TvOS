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
        case is RoomerAssistState.Type:
            return true
        case is RoomerGiveUpState.Type:
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
        var waitingFor: ServiceCategory = .checkIn
        var colorService: UIColor = .green
        
        // TODO: Put right textureName
        if(previousState != nil) {
            switch previousState! {
            case is RoomerRoomState:
                // Wait a time on room for bag
                print("Wait a time on room for bag")
                waitTimer = WaitTimer.bag
                textureName = nil
                waitingFor = .bag
                colorService = .orange
            case is RoomerRoomServiceState:
                // Wait a time on room for Room service
                print("Wait a time on room for Room service")
                waitTimer = WaitTimer.roomService
                textureName = nil
                waitingFor = .food
                colorService = .red
            case is RoomerLeaveState:
                // Wait a time on reception
                // Go to RoomerListnerState
                print("Wait a time to Check Out")
                waitTimer = WaitTimer.reception
                textureName = nil
                waitingFor = .checkOut
                colorService = .blue
            default:
                break
            }
        }
        
        self.entity.changeWaitingFor(waitingFor)
        
        self.animate(imageNamed: textureName, duration: waitTimer, color: colorService)
    }
    
    func animate(imageNamed: String?,
                 duration: TimeInterval,
                 color: UIColor) {
        
        guard let node = self.entity.component(ofType: RenderComponent.self)?.node else {
            return
        }
        
        guard let ballon = self.entity.component(ofType: BallonComponent.self) else {return}
        
        if (imageNamed != nil) {
            ballon.changeTexture(forTexture: SKTexture(imageNamed: imageNamed!))
        }
        
        ballon.showBallon()
        ballon.changeColor(color)
        
        let idleWait = SKAction.wait(forDuration: duration)
        
        node.run(idleWait) {
            node.removeAllActions()
            ballon.dismissBallon()
            self.stateMachine?.enter(RoomerGiveUpState.self)
        }
    }
}
