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
         ballon = SKSpriteNode.init(texture: texture,
                                       color: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), size:
                    CGSize.init(width: BallonSize.width,
                                height: BallonSize.height)
                    )
    
        nodeSuper.addChild(ballon)
        
        ballon.zPosition = nodeSuper.zPosition + 10
        ballon.position.y = nodeSuper.size.height + BallonSize.posY
        ballon.alpha = 0.0
        
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
