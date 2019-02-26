//
//  BallonComponent.swift
//  ChaoticHotel-TvOS
//
//  Created by Renato Lopes on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import SpriteKit
import GameplayKit

class BallonComponent: GKComponent {
    let ballon: SKSpriteNode!
    init(nodeSuper: SKSpriteNode,
         andTexture texture: SKTexture?) {
        
        ballon = SKSpriteNode(
            texture: texture,
            color: .clear,
            size: texture!.size())
    
        nodeSuper.addChild(ballon)
        ballon.zPosition = nodeSuper.zPosition + 10
        ballon.alpha = 0.0
        
        if (nodeSuper.zRotation > 0) {
            ballon.position.x = 100
            ballon.zRotation = -nodeSuper.zRotation
        } else {
            ballon.position.y = (nodeSuper.size.height) + BallonSize.posY
        }
        
        super.init()
    }
    func showBallon() {
        self.ballon.alpha = 1.0
    }
    
    func dismissBallon() {
        self.ballon.alpha = 0.0
    }
    
    func changeTexture(forTexture texture: SKTexture?) {
        self.ballon.texture = texture
    }
    
    func changeColor(_ color: UIColor) {
        self.ballon.color = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
