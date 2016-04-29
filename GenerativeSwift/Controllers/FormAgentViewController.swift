//
//  FormAgentViewController.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/29/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class FormAgentViewController: StupidAgentViewController {
    
    let formResolution = 15
    let stepSize = 4
    let initRadius = 100.0

    var points = [Point]()
    var center = Point()
    
    override init() {
        super.init()
        title = "Forms Made by Agents"
        trash = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        super.setup()
        
        canvas.addTapGestureRecognizer { locations, center, state in
            self.point = center
            self.clearPoints()
        }
    }
    
    override func draw() {
        if point.x != 0 || point.y != 0 {
            center.x += (point.x - center.x) * 0.01
            center.y += (point.y - center.y) * 0.01
        }
        
        (0..<formResolution).forEach { i in
            points[i].x += Double(random(min: -stepSize * 100, max: stepSize * 100)) / 100
            points[i].y += Double(random(min: -stepSize * 100, max: stepSize * 100)) / 100
        }

        let path = Path()
        let first = Point(center.x + points[0].x, center.y + points[0].y)
        let last = Point(center.x + points[formResolution - 1].x, center.y + points[formResolution - 1].y)
        path.moveToPoint(first)
        1.stride(to: formResolution - 1, by: 2).forEach { i in
            let end = Point(center.x + points[i + 1].x, center.y + points[i + 1].y)
            let control = Point(center.x + points[i].x, center.y + points[i].y)
            path.addQuadCurveToPoint(end, control: control)
        }
        path.addQuadCurveToPoint(first, control: last)
        
        let shape = Shape(path)
        shape.lineWidth = 0.5
        shape.fillColor = nil
        shape.strokeColor = Color(UIColor(white: 0, alpha: 0.4))
        canvas.add(shape)
    }
    
    override func clear() {
        super.clear()
        clearPoints()
    }
    
    func clearPoints() {
        
        points = [Point]()
        center = point
        let angle = degToRad(360 / Double(formResolution))
        (0..<formResolution).forEach { i in
            points.append(
                Point(
                    cos(angle * Double(i)) * initRadius,
                    sin(angle * Double(i)) * initRadius
                )
            )
        }
    }
}
