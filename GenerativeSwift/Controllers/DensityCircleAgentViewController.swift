//
//  DensityCircleAgentViewController.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 5/3/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class DensityCircleAgentViewController: DensityAgentViewController {
    
    override var minRadius: Double {
        return 1.0
    }
    override var maxRadius: Double {
        return 40.0
    }
    let minMouseRect = 100.0
    
    override var initialRadius: Double {
        return mouseRect
    }
    
    override init() {
        super.init()
        title = "Density Structures in Circle Made by Agents"
        mouseRect = minMouseRect
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawCircles() {
        var intersection = true
        var count = 0
        
        var r = 0.0
        var point = Point()

        var closestIndex = 0

        while intersection && count < 100 {
            point = Point(
                Double(random(min: Int(points[0].x - radiuses[0]), max: Int(points[0].x + radiuses[0]))),
                Double(random(min: Int(points[0].y - radiuses[0]), max: Int(points[0].y + radiuses[0])))
            )
            r = minRadius
            
            intersection = false
            for (i, p) in points.enumerated() {
                if i == 0 {
                    continue
                }
                let dist = distance(p, rhs: point)
                if dist < r + radiuses[i] {
                    intersection = true
                    break
                }
            }
            
            if !intersection {
                r = canvas.width

                for (i, p) in points.enumerated() {
                    if i == 0 {
                        continue
                    }
                    let d = distance(p, rhs: point) - radiuses[i]
                    if r > d  {
                        r = d
                        closestIndex = i
                    }
                }
                
                r = min(r, maxRadius)
                
                if radiuses[0] - distance(points[0], rhs: point) - r < 0 {
                    intersection = true
                }
            }
            
            count += 1
        }
        
        if !intersection {            
            points.append(point)
            radiuses.append(r)
            addCircle(point, radius: r)
            
            let line = Line(begin: point, end: points[closestIndex])
            line.lineWidth = 0.75
            line.strokeColor = Color.init(red: 226, green: 185, blue: 0, alpha: 1)
            
            canvas.add(line)
        }
    }

    override func upTapped(_ sender: AnyObject) {
        super.upTapped(sender)
        clear()
    }
    
    override func downTapped(_ sender: AnyObject) {
        mouseRect = max(mouseRect - 4.0, minMouseRect)
        clear()
    }
}
