//
//  CashRegisterComponent.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 27/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class CashRegisterComponent: GKComponent {
    
    var amount: Int
    var entityManager: EntityManager
    
    init(entityManager: EntityManager) {
        self.amount = 0
        self.entityManager = entityManager
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCashRegister(withAmount amount: Int) {
        self.amount += amount
    }
    
}
