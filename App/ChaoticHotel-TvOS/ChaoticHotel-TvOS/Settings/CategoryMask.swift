//
//  CategoryMask.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 18/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit

struct CategoryMask {
    static let base: UInt32 = 0b1
    static let starff = CategoryMask.base << 0
    static let roomer = CategoryMask.base << 1
    static let interaction = CategoryMask.base << 2
    static let items = CategoryMask.base << 3
    static let walls = CategoryMask.base << 4
    static let floor = CategoryMask.base << 5
    
    static let allMasks: [UInt32] = [
        CategoryMask.starff,
        CategoryMask.roomer,
        CategoryMask.interaction,
        CategoryMask.items,
        CategoryMask.walls,
        CategoryMask.floor
    ]
    
    static func contactWithAllCategories(less: [UInt32] = []) -> UInt32 {
        var result: UInt32 = 0b00
        
        for category in CategoryMask.allMasks {
            if (!less.contains(category)) {
                result |= category
            }
        }
        
        return result
    }
}
