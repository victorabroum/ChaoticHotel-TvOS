//
//  Staff.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class Staff: GKEntity {
    
    init(withImageNamed imageNamed: String) {
        super.init()
        
        // Add RenderComponent
        let renderComponent = RenderComponent(imageNamed: imageNamed)
        self.addComponent(renderComponent)
        self.addComponent(MoveComponent())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
