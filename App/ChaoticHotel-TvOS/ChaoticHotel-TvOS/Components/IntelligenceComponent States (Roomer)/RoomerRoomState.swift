//
//  RoomerRoomState.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class RoomerRoomState: GKState {
    
    var entity: Roomer!
    
    init(_ entity: Roomer) {
        self.entity = entity
        super.init()
    }

   override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is RoomerListnerState.Type:
            return true
        default:
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        
        guard let node = self.entity.component(ofType: RenderComponent.self)?.node else { return }
        
        guard let scene = node.scene as? GameScene else { return }
        
        scene.gameWorld.hotelEntity.enterOnRoom(roomer: self.entity)
        
        // Spawn Bag
        let bag = Items(
            imageNamed: "bag",
            serviceCategory: .bag,
            isHold: false,
            categoryMask: .bag,
            lifeTime: WaitTimer.bag + 2
        )
        guard let bagNode = bag.component(ofType: RenderComponent.self)?.node else { return }
        bagNode.position = scene.childNode(withName: "luggagedCart")!.position
        scene.entityManager.add(bag)
        
        node.run(SKAction.wait(forDuration: 2)) {
            self.stateMachine?.enter(RoomerListnerState.self)
        }
    }

}
