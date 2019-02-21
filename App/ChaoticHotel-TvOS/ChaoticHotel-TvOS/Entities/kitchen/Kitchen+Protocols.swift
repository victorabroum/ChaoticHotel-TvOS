//
//  Kitchen+Protocols.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 19/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

extension Kitchen: InteractDelegate {
    func action(callBy owner: GKEntity) {
        
        if let staff = owner as? Staff {
            if (staff.holdItem != nil) { return }
            
            if let staff = owner as? Staff {
                let foodPlate = Items(
                    imageNamed: "food",
                    serviceCategory: .food,
                    isHold: true,
                    categoryMask: .food,
                    lifeTime: WaitTimer.foodLifeTime)
                guard let gameScene =
                    staff.component(ofType: RenderComponent.self)!.node.scene as? GameScene else { return }
                gameScene.entityManager.add(foodPlate)
                let node = foodPlate.component(ofType: RenderComponent.self)!.node
                node.color = UIColor(red: 0.79, green: 0.15, blue: 0.15, alpha: 1.0)
                staff.holdItem = foodPlate
                foodPlate.hold(callBy: staff)
            }
        }
        
    }
}
