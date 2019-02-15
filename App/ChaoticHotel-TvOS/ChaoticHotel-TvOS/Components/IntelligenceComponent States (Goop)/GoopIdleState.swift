//
//  GoopIdleState.swift
//  ChaoticHotel-TvOS
//
//  Created by Renato Lopes on 15/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import GameplayKit

class GoopIdleState: GKState {
    let entity: Goop!
    
    init(_ entity: Goop) {
        self.entity = entity
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return false
    }
    
    override func didEnter(from previousState: GKState?) {
        
        //TODO - Adificionar a logica de mostrar o balão
        let ballon = self.entity.component(ofType: BallonComponent.self)
        ballon?.showBallon()
        
        //TODO - Adicionar a logica de interação

//        self.entity.stateMachine.enter(GoopCleanerState.self)
    }
    
}
