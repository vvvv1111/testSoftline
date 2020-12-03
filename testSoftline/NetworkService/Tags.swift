//
//  Tags.swift
//  testSoftline
//
//  Created by Vladimir on 29.11.2020.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import Foundation

enum Tags:Int{
    case ObjectiveC = 0
    case iOS = 1
    case Xcode = 2
    case CocoaTouch = 3
    case iPhone = 4
    
    static var count: Int { return Tags.iPhone.rawValue + 1 }
    
    
    var description: String {
        switch self {
        case .ObjectiveC: return "ObjectiveC"
        case .iOS   : return "iOS"
        case .Xcode  : return "Xcode"
        case .CocoaTouch : return "CocoaTouch"
        case .iPhone : return "iPhone"
        }
    }
}
