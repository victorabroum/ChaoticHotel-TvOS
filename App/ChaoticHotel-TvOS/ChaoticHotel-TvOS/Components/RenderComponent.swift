//
//  RenderComponent.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class RenderComponent: GKComponent {
    
    var node: SKSpriteNode
    var position: CGPoint = .zero
    
    init(imageNamed: String, onPosition pos: CGPoint = .zero) {
        
        // Initialize a texture pass a imageName
        let texture = SKTexture(imageNamed: imageNamed)
        
        // Initiliaze the node with rigth texture
        self.node = SKSpriteNode(texture: texture, color: .clear, size: texture.size())
        self.node.name = "\(imageNamed)"
        
        // Initiliaze the positon
        self.position = pos
        
        // Set initial position to Node
        self.node.position = pos
        
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
