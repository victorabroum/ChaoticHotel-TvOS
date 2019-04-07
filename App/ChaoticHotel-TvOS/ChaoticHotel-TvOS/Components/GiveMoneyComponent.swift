//
//  GiveMoneyComponent.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 07/04/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class GiveMoneyComponent: GKComponent {
    
    var amount: Int
    
    init (amount: Int) {
        self.amount = amount
        super.init()
    }
    
    func giveCash() {
        let userInfo = ["amount": amount]
        NotificationCenter.default.post(name: .didRecivedCash, object: self, userInfo: userInfo)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
