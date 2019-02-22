//
//  GoopCleanerState.swift
//  ChaoticHotel-TvOS
//
//  Created by Renato Lopes on 15/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import GameplayKit

class GoopCleanerState: GKState {
    let entity: Goop!
    
    init(_ entity: Goop) {
        self.entity = entity
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is GoopCleanerState.Type:
            return true
        default:
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        
        let spriteNode = self.entity.component(ofType: RenderComponent.self)
        guard let node = spriteNode?.node else {return}
        
        guard let body = node.physicsBody else { return }
        
        for contactBody in body.allContactedBodies() {
            if let staff = contactBody.node?.entity as? Staff {
                guard let moveComp = staff.component(ofType: MoveComponent.self) else { return }
                moveComp.maxSpeed = PlayerConstants.normal
            }
        }
        
        if let gameScene = node.scene as? GameScene {
            gameScene.entityManager.remove(self.entity)
        }
        
        //TODO - Liberar pontuação para o usuário
        
    }
}
