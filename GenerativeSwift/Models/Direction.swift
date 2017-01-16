//
//  Direction.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/23/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import Foundation

enum Direction: UInt32 {
    case north
    case northEast
    case east
    case southEast
    case south
    case southWest
    case west
    case northWest
    
    static var last: Direction {
        return .northWest
    }
    
    static func random() -> Direction {
        return Direction(rawValue: arc4random() % (last.rawValue + 1))!
    }
}
