//
//  Reception+Protocols.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 18/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

extension Reception: InteractDelegate {
    func action(callBy owner: GKEntity) {
        if let staff = owner as? Staff {
            if (staff.holdItem != nil) { return }
            if (!self.hotel.receptionQueue.isEmpty) {
                // TODO: Add animation to check in
                let roomer = self.hotel.exitQueue()
                guard let staffNode = staff.component(ofType: RenderComponent.self) else { return }
                let colorize = SKAction.colorize(
                    with: .orange,
                    colorBlendFactor: 1,
                    duration: 0.75)
                let receptionAnimation =
                    SKAction.sequence([colorize, colorize.reversed()])
                staffNode.node.run(receptionAnimation) {
                    roomer!.assisted()
                }
            }
        }
        
    }
    
}
