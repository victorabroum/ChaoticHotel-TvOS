//
//  Items+Protocols.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 19/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

extension Items: InteractDelegate {
    func action(callBy owner: GKEntity) {
        print("GET A ITEM type \(self.serviceCategory)")
        print("Put service type on Entity")
    }
}
