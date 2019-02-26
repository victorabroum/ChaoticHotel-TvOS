//
//  EntityManager+Utils.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 26/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

extension EntityManager {
    func allGoop() -> [Goop] {
        var result = [Goop]()
        for entity in self.entities where entity is Goop {
            if let goop = entity as? Goop {
                result.append(goop)
            }
        }
        return result
    }
}
