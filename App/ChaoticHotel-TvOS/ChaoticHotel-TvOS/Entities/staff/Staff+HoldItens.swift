//
//  Staff+HoldItens.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 19/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

extension Staff {
    func deliver(entityManager: EntityManager, aService service: ServiceComponent) {
        
        if (service.waitForServiceType == self.service) {
            print("DELIVER")
            service.deliverService(ofType: self.service)
            if (self.holdItem != nil && self.service != .clean) {
                entityManager.remove(self.holdItem)
                self.holdItem = nil
                self.service = .listen
            }
        }
    }
}
