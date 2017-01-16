//
//  CirclePolygon.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/23/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import Foundation
import C4

open class CirclePolygon: Polygon {
    init(_ points: [Point], _ size: Size) {
        super.init()
        
        let path = Path()
        for point in points {
            path.addEllipse(Rect(point, size))
        }
        self.path = path
        
        adjustToFitPath()
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
