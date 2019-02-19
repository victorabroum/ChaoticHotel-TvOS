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
            if (staff.isholdItem) { return }
        }
        if (!self.hotel.receptionQueue.isEmpty) {
            // TODO: Add animation to check in
            print("Animation on reception")
            // And to teleport Roomer
            print("RECEption assisted")
            self.hotel.receptionQueue.first!.assisted()
        }
    }
    
}
