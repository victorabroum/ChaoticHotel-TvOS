//
//  JoystickAction.swift
//  ChaoticHotel-TvOS
//
//  Created by Renato Lopes on 18/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation

enum JoystickAction: String, CaseIterable {
    case tap = "tap-action"
    case booster = "booster-action"
    case none = "none-action"
    //others actions
    
   static func getAction(withValue value: String) -> JoystickAction {
        for action in JoystickAction.allCases {
            if action.rawValue == value {
                return action
            }
        }
        return JoystickAction.none
    }
}
