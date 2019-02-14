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
    
    // Flag to track if Entity is in Room
    var isInRoom: Bool = false
    
    // To track what the Entity is waiting
    var waitingFor: WaitingFor! = nil
    
    // To track what room Roomer is allocated
    var room: SKNode! = nil
    
    init(withImageNamed imageNamed: String) {
        super.init()
        
        // Preapre State Machine
        self.prepareStateMachine()
        
        // Add RenderComponent
        let renderComponent = RenderComponent(imageNamed: imageNamed)
        // Add BallonComponent for show icons
        let ballonComponent = BallonComponent.init(nodeSuper: renderComponent.node!, andTexture: nil)
        
        self.addComponent(ballonComponent)
        self.addComponent(renderComponent)
        self.addComponent(MoveComponent())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("ME QUEBREI")
    }
}
