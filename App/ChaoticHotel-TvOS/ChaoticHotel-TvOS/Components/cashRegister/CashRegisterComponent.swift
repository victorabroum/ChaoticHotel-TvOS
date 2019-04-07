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
    
    override init() {
        self.amount = 0
        super.init()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(addCashRegister(_:)),
            name: .didRecivedCash,
            object: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addCashRegister(_ notification: Notification) {
        
        if let userInfo = notification.userInfo, let amount = userInfo["amount"] as? Int {
            self.amount += amount
            guard let labelComp = entity?.component(ofType: LabelComponent.self) else { return }
            labelComp.content = "\(self.amount)"
        }
    }
    
}
