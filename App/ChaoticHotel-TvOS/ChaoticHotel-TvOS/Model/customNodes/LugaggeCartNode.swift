//
//  LugaggeCartNode.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 20/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit

class LugaggeCartNode: SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let move = SKAction.moveBy(x: CGFloat.random(in: 10...15), y: CGFloat.random(in: 10...15), duration: 2)
        let sequence = SKAction.sequence([
            move,
            move.reversed()
            ])
        self.run(SKAction.repeatForever(sequence))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
