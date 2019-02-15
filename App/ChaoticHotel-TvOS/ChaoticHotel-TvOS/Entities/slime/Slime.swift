//
//  Slime.swift
//  ChaoticHotel-TvOS
//
//  Created by Renato Lopes on 14/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import SpriteKit
import GameplayKit

class Slime: GKEntity {
    var stateMachine: GKStateMachine!
    
    init(withImageNamed name: String) {
        super.init()
        // Created instance components
        let renderComponent = RenderComponent.init(imageNamed: name)
        let moveComponent = MoveComponent.init()
        
        // Add components to Entity
        self.addComponent(moveComponent)
        self.addComponent(renderComponent)
        self.prepareStateMachine()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
