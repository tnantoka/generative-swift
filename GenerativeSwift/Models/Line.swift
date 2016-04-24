//
//  Line.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/24/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import Foundation
import C4

extension Line {
    func contains(point: Point) -> Bool {
//        return hitTest(point)
        let x0 = points[0].x
        let y0 = points[0].y
        let x1 = points[1].x
        let y1 = points[1].y
        let x2 = point.x
        let y2 = point.y
        let l1 = sqrt(pow((x1 - x0), 2) + pow((y1 - y0), 2))
        let l2 = sqrt(pow((x2 - x0), 2) + pow((y2 - y0), 2))
        
        let v = (x1 - x0) * (x2 - x0) + (y1 - y0) * (y2 - y0)
        let l = l1 * l2
        
        let margin = 1.0
        return  v > l - margin && v < l + margin && l1 >= l2
    }
}