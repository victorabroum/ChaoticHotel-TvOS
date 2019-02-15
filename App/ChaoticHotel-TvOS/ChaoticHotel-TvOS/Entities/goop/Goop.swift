//
//  Goop.swift
//  ChaoticHotel-TvOS
//
//  Created by Renato Lopes on 15/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import GameplayKit
import SpriteKit

class Goop: GKEntity {
    var stateMachine: GKStateMachine!
    
    init(withImage image: String) {
        super.init()
        
        let renderComponent = RenderComponent.init(imageNamed: image)
        let ballonComponent = BallonComponent.init(nodeSuper: renderComponent.node!, andTexture: nil)
        
        self.addComponent(renderComponent)
        self.addComponent(ballonComponent)
        self.prepateStateMachine()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
