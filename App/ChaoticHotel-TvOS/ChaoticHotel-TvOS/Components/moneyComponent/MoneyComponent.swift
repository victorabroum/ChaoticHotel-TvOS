//
//  MoneyComponent.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 27/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class MoneyComponent: GKComponent {
    var amount: Int
    
    init(initialAmount amount: Int) {
        self.amount = amount
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
