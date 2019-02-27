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
    var textureName: String
    init(nodeSuper: SKSpriteNode,
         andTextureNamed textureNamed: String) {
        self.textureName = textureNamed
        let texture = SKTexture(imageNamed: textureNamed)
        ballon = SKSpriteNode(
            texture: texture,
            color: .clear,
            size: texture.size())
    
        nodeSuper.addChild(ballon)
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
        let waitTime = self.waitTime()
        let moveUp = SKAction.moveBy(x: 0, y: 10, duration: 1)
        let sequence = SKAction.sequence([moveUp, moveUp.reversed()])
        self.ballon.run(SKAction.repeatForever(sequence))
        if (waitTime != 0) {
//            self.ballon.run(SKAction.colorize(
//                with: .red,
//                colorBlendFactor: 1,
//                duration: waitTime))
            self.ballon.run(SKAction.fadeAlpha(to: 0, duration: waitTime))
        }
        
    }
    
    func dismissBallon() {
        self.ballon.alpha = 0.0
        self.ballon.removeAllActions()
    }
    
    func changeTexture(forTexture textureNamed: String) {
        self.textureName = textureNamed
        let texture = SKTexture(imageNamed: textureNamed)
        self.ballon.texture = texture
    }
    
    func changeColor(_ color: UIColor) {
        self.ballon.color = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
