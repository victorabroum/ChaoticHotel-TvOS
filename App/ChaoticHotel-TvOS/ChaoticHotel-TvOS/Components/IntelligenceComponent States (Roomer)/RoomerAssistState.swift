//
//  RoomerAssistState.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class RoomerAssistState: GKState {
    
    var entity: Roomer!
    
    init(_ entity: Roomer) {
        self.entity = entity
        super.init()
    }

   override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is RoomerRoomState.Type:
            return true
        case is RoomerWaitState.Type:
            return true
        case is RoomerListnerState.Type:
            return true
        case is RoomerGoOutState.Type:
            return true
        default:
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        
        self.entity.removeComponent(ofType: ServiceComponent.self)
        
        guard let roomerNode = self.entity.component(ofType: RenderComponent.self)?.node else { return }
        
        guard let ballonNode = self.entity.component(ofType: BallonComponent.self) else { return }
        
        ballonNode.dismissBallon()
        
        if (self.entity.wantLeave) {
            
            guard let scene = roomerNode.scene as? GameScene else { return }
            
            // Roomer leave the room
            scene.gameWorld.hotelEntity.addAvailableRoom(self.entity.room)
            
            // Change to none room for the Roomer
            self.entity.changeRoom(nil)
            
            self.stateMachine?.enter(RoomerGoOutState.self)
        } else if self.entity.isInRoom {
            roomerNode.run(SKAction.playSoundFileNamed("door_knock", waitForCompletion: false))
            self.stateMachine?.enter(RoomerWaitState.self)
        } else {
            self.entity.isInRoom  = true
            self.stateMachine?.enter(RoomerRoomState.self)
        }
    }

}
