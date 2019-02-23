//
//  CategoryMask.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 18/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit

enum CategoryMask: UInt32, CaseIterable {
    case staff = 0b1
    case roomer = 0b10
    case reception = 0b100
    case mop = 0b1000 // Esfregão
    case bag = 0b10000
    case food = 0b100000
    case elevator = 0b1000000
    case goop = 0b10000000
    case walls = 0b100000000
    
    // Do an OR operation to all categories you want collide or contact
    public static func contactWithAllCategory(less: [CategoryMask] = []) -> UInt32 {
        
        var result: UInt32 = 0b00
        
        for category in CategoryMask.allCases {
            if (!less.contains(category)) {
                result |= category.rawValue
            }
        }
        return result
    }
}
