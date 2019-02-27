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
    
    var entity: Roomer!
    
    init(_ entity: Roomer) {
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
        
        // Go to Reception
        guard let node = self.entity.component(ofType: RenderComponent.self)?.node else {
            return
        }
        
        guard let scene = node.scene as? GameScene else { return }
        
        if (self.entity.room != nil) {
            scene.gameWorld.hotelEntity.addAvailableRoom(self.entity.room)
        }
        
        if (!self.entity.isInRoom) {
            _ = scene.gameWorld.hotelEntity.exitQueue()
            
        }
        guard let baloon = self.entity.component(ofType: BallonComponent.self) else { return }
        baloon.changeTexture(forTexture: "baloon_angry")
        baloon.showBallon()
        node.run(SKAction.playSoundFileNamed("angry_voice", waitForCompletion: false))
        self.stateMachine!.enter(RoomerGoOutState.self)
    }

}
