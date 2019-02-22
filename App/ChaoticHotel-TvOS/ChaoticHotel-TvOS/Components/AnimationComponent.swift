//
//  AnimationComponent.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 22/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

enum AnimationState: String {
    case idle
    case walk
}

class AnimationComponent: GKComponent {
    
    var nodeToAnimate: SKNode!
    var animationState: AnimationState = .idle
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
