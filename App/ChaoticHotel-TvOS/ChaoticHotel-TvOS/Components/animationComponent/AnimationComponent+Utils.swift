//
//  AnimationComponent+Utils.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 22/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

extension AnimationComponent {
    
    func animateNode(withState state: AnimationState) {
    
        if (state != self.animationState) {
            if(self.nodeToAnimate.hasActions()) {
                print("Remove actions")
                self.nodeToAnimate.removeAction(
                    forKey: AnimationComponent.animationKey)
            }
            print("VOU ANIMAR \(state)")
            self.animationState = state
            let textures =
                self.texturesToAnimate(withName: "\(self.textureAtlasName)")
            self.nodeToAnimate.run(
                SKAction.repeatForever(
                    SKAction.animate(
                        with: textures,
                        timePerFrame: 0.1)),
                withKey: AnimationComponent.animationKey)
        }
    }
}

// Actions Keys constants
extension AnimationComponent {
    static let animationKey = "animation.comp.key"
}
