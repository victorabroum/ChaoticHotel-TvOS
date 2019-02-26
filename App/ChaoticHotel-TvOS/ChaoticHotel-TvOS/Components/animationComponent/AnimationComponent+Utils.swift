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
                self.nodeToAnimate.removeAction(
                    forKey: AnimationComponent.animationKey)
            }
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
    
    func animateNode(
        withState state: AnimationState!,
        completion: @escaping () -> Void) {
        
        if (state != nil && state != self.animationState) {
            if(self.nodeToAnimate.hasActions()) {
                self.nodeToAnimate.removeAction(
                    forKey: AnimationComponent.animationKey)
            }
            self.animationState = state
            
            let textures =
                self.texturesToAnimate(withName: "\(self.textureAtlasName)")
            
            self.nodeToAnimate.run(SKAction.animate(
                with: textures,
                timePerFrame: 0.1)) {
                    completion()
            }
        } else {
            completion()
        }
        
    }
}

// Actions Keys constants
extension AnimationComponent {
    static let animationKey = "animation.comp.key"
}
