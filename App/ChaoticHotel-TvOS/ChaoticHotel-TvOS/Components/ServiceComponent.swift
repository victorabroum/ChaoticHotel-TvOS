//
//  ServiceComponent.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 18/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class ServiceComponent: GKComponent {
    
    var owner: AssistEntity
    var waitForServiceType: ServiceCategory
    
    init(owner: AssistEntity, serviceCategory: ServiceCategory) {
        self.owner = owner
        self.waitForServiceType = serviceCategory
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func deliverService(ofType service: ServiceCategory) {
        
        if (self.waitForServiceType == service) {
            print("Delivered \(service)")
            self.owner.assistDelegate?.assisted()
        } else {
            print("Wrond service delivered \(service)")
        }
    }
    
}
