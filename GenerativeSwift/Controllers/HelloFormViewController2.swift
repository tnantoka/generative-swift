//
//  HelloFormViewController2.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/16/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class HelloFormViewController2: HelloFormViewController {

    var strokeColor: Color {
        return Color(UIColor(white: 0, alpha: 0.25))
    }
    
    override init() {
        super.init()
        title = "Hello Form 2"
        trash = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
    }

    override func createForm(circleResolution: Int, radius: Double, angle: Double) {
        let points = (0...circleResolution).map { i in
            return circlePoint(i, angle: angle, radius: radius)
        }
        let polygon = Polygon(points)
        polygon.strokeColor = strokeColor
        polygon.lineWidth = 2
        canvas.add(polygon)
    }
}
