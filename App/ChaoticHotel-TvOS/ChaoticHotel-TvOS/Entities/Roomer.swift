//
//  Roomer.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class Roomer: GKEntity {
    
    var stateMachine: GKStateMachine!
    
    init(withImageNamed imageNamed: String) {
        super.init()
        
        // Preapre State Machine
        self.prepareStateMachine()
        
        // Add RenderComponent
        let renderComponent = RenderComponent(imageNamed: imageNamed)
        self.addComponent(renderComponent)
        self.addComponent(MovementComponent())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("ME QUEBREI")
    }
}
