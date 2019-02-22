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
    case inactive
}

class AnimationComponent: GKComponent {
    
    var nodeToAnimate: SKNode!
    var animationState: AnimationState = .inactive
    var textureAtlasName: String
    
    init(texturesAtlasName: String) {
        self.textureAtlasName = texturesAtlasName
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func texturesToAnimate(withName name: String) -> [SKTexture] {
        var textures = [SKTexture]()
        
        let atlas = SKTextureAtlas(named: "\(name)_\(self.animationState)")
        
        for index in 1...atlas.textureNames.count {
            let frameTexture = SKTexture(imageNamed: "\(name)_\(self.animationState)_0\(index)")
            textures.append(frameTexture)
        }
        
        return textures
    }
    
}
