//
//  Elevator+Protocols.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 18/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation

extension Elevator: InteractDelegate {
    // TODO: Use Constants
    func interactionAction() {
        if (self.transport != nil) {
            guard let node = self.transport.component(ofType: RenderComponent.self)?.node else { return }
            switch self.goTo {
            case .down:
                node.position.y -= 450
            case .upper:
                node.position.y += 450
            }
        }
    }
}
