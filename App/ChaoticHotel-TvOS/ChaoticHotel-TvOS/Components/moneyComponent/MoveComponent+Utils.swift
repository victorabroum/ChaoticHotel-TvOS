//
//  MoveComponent+Utils.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 27/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation

extension MoneyComponent {
    func giveSome(tip: Int) {
        self.amount += tip
        print("ATUAL TIP \(self.amount)")
    }
    
    func getAmount() -> Int {
        return self.amount
    }
}
