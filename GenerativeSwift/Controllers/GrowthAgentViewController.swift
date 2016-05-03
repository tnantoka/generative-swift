//
//  GrowthAgentViewController.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 5/3/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class GrowthAgentViewController: StupidAgentViewController {
    
    let maxCount = 1000
    var count = 1
    let initRadius = 100.0
    
    var points = [Point]()
    var radiuses = [Double]()
    
    var temps = [Shape]()
    var drawTemp = false
    
    var initialRadius: Double {
        return 10.0
    }
    
    override init() {
        super.init()
        title = "Growth Structures Made by Agents"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        super.setup()
        
        canvas.addTapGestureRecognizer { locations, center, state in
            self.drawTemp = !self.drawTemp
        }
    }
    
    override func draw() {
        for temp in temps {
            temp.removeFromSuperview()
        }

        guard points.count < maxCount else { return }
        
        if points.count == 1 {
            addCircle(points[0], radius: radiuses[0])
        }
        
        drawCircles()
    }
    
    func drawCircles() {
        let r = Double(random(min: 1, max: 8))
        let intR = Int(r)
        let point = Point(
            Double(random(min: intR, max: Int(canvas.width) - intR)),
            Double(random(min: intR, max: Int(canvas.height) - intR))
        )
        
        var closestDist = Double.infinity
        var closestIndex = 0
        for (i, p) in points.enumerate() {
            let dist = distance(p, rhs: point)
            if dist < closestDist {
                closestDist = dist
                closestIndex = i
            }
        }
        
        if drawTemp {
            let tempCircle = Circle(center: point, radius: r)
            tempCircle.fillColor = nil
            canvas.add(tempCircle)
            
            let tempLine = Line(begin: point, end: points[closestIndex])
            canvas.add(tempLine)
            
            temps.append(tempCircle)
            temps.append(tempLine)
        }
        
        let angle = atan2(point.y - points[closestIndex].y, point.x - points[closestIndex].x)
        let closestPoint = Point(
            points[closestIndex].x + cos(angle) * (radiuses[closestIndex] + r),
            points[closestIndex].y + sin(angle) * (radiuses[closestIndex] + r)
        )
        points.append(closestPoint)
        radiuses.append(r)
        addCircle(closestPoint, radius: r)
    }
    
    func addCircle(center: Point, radius: Double) {
        let circle = Circle(center: center, radius: radius)
        configureCircle(circle)
        canvas.add(circle)
    }
    
    func configureCircle(circle: Circle) {
        circle.strokeColor = nil
        circle.fillColor = Color(UIColor(white: 50.0 / 255.0, alpha: 1.0))
    }
    
    override func clear() {
        super.clear()

        points = [Point]()
        radiuses = [Double]()
        
        let point = canvas.center
        let r = initialRadius
        points.append(point)
        radiuses.append(r)
    }
}
