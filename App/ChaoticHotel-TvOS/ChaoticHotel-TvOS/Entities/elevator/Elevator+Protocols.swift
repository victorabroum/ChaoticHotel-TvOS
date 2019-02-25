//
//  Elevator+Protocols.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 18/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

extension Elevator: InteractDelegate {
    func action(callBy owner: GKEntity) {
        guard let node = owner.component(ofType: RenderComponent.self)?.node else { return }
        guard let gameScene = node.scene as? GameScene else { return }
        switch self.goTo {
        case .goDown:
            node.position.y = gameScene.childNode(withName: "elevatorGoUp")!.position.y
        case .goUp:
            node.position.y = gameScene.childNode(withName: "elevatorGoDown")!.position.y
        }
    }
    
}
