//
//  Direction.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/23/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import Foundation

enum Direction: UInt32 {
    case North
    case NorthEast
    case East
    case SouthEast
    case South
    case SouthWest
    case West
    case NorthWest
    
    static var last: Direction {
        return .NorthWest
    }
    
    static func random() -> Direction {
        return Direction(rawValue: arc4random() % (last.rawValue + 1))!
    }
}
