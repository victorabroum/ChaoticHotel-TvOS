//
//  Reception+Protocols.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 18/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation

extension Reception: InteractDelegate {
    func interactionAction() {
        if (!self.hotel.receptionQueue.isEmpty) {
            // TODO: Add animation to check in
            // And to teleport Roomer
            print("RECEption assisted")
            self.hotel.receptionQueue.first!.assisted()
        }
    }
}
