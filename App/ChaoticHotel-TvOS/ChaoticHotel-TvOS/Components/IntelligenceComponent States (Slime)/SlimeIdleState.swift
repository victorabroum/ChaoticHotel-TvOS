//
//  SlimeIdleState.swift
//  ChaoticHotel-TvOS
//
//  Created by Renato Lopes on 14/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import SpriteKit
import GameplayKit

class SlimeIdleState: GKState {
    
    var entity: Slime!
    
    init(_ entity: Slime) {
        self.entity = entity
        super.init()
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is SlimeCrawlingState.Type:
            return true
        default:
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
       
        //TODO Slime - Aguardar o tempo para voltar a andar
        guard previousState != nil else{
            print("Bora correeeeer!")
            self.entity.stateMachine.enter(SlimeCrawlingState.self)
            return
        }
        
        print("Cansei de andar")
        let slimeComponent = self.entity.component(ofType: RenderComponent.self)
        guard let slimeNode = slimeComponent?.node else {return}
        
        //Esperar para voltar a andar
        slimeNode.run(SKAction.wait(forDuration: 5))
        print("Action Wait")
    }
}
