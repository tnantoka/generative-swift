//
//  DensityAgentViewController.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 5/3/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class DensityAgentViewController: GrowthAgentViewController {
    
    var minRadius: Double {
        return 3.0
    }
    var maxRadius: Double {
        return 50.0
    }
    var mouseRect = 30.0
    
    var mousePressed = false
    
    override var initialRadius: Double {
        return maxRadius
    }

    override init() {
        super.init()
        title = "Density Structures Made by Agents"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let up = UIBarButtonItem(title: "↑", style: .plain, target: self, action: #selector(upTapped))
        let down = UIBarButtonItem(title: "↓", style: .plain, target: self, action: #selector(downTapped))
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarItems = [flexible, startItem, flexible, stopItem, flexible, up, down, flexible]
    }
    
    override func setup() {
        super.setup()
        
        let _ = canvas.addTapGestureRecognizer { locations, center, state in
            self.mousePressed = !self.mousePressed
            self.point = center
        }
    }
    
    override func drawCircles() {
        var intersection = true
        var count = 0
        
        var r = 0.0
        var point = Point()
        
        while intersection && count < 100 {
            if !mousePressed {
                point = Point(
                    Double(random(min: Int(maxRadius), max: Int(canvas.width - maxRadius))),
                    Double(random(min: Int(maxRadius), max: Int(canvas.height - maxRadius)))
                )
                r = minRadius
            } else {
                point = Point(
                    Double(random(min: Int(self.point.x - mouseRect / 2), max: Int(self.point.x + mouseRect / 2))),
                    Double(random(min: Int(self.point.y - mouseRect / 2), max: Int(self.point.y + mouseRect / 2)))
                )
                r = 1
            }
            
            intersection = false
            for (i, p) in points.enumerated() {
                let dist = distance(p, rhs: point)
                if dist < r + radiuses[i] {
                    intersection = true
                    break
                }
            }
         
            count += 1
        }
        
        if !intersection {
            r = canvas.width
            var closestIndex = 0
            
            for (i, p) in points.enumerated() {
                let d = distance(p, rhs: point) - radiuses[i]
                if r > d  {
                    r = d
                    closestIndex = i
                }
            }
            
            r = min(r, maxRadius)
            
            points.append(point)
            radiuses.append(r)
            addCircle(point, radius: r)
            
            let line = Line(begin: point, end: points[closestIndex])
            line.lineWidth = 0.75
            line.strokeColor = Color.init(red: 226, green: 185, blue: 0, alpha: 1)
            
            canvas.add(line)
        }
        
        if mousePressed {
            let rect = CGRect(x: self.point.x - mouseRect / 2, y: self.point.y - mouseRect / 2, width: mouseRect, height: mouseRect)
            let tempRect = Rectangle(frame: Rect(rect))
            tempRect.fillColor = nil
            tempRect.strokeColor = Color.init(red: 226, green: 185, blue: 0, alpha: 1)
            tempRect.corner = Size()
            canvas.add(tempRect)
            temps.append(tempRect)
        }
    }
    
    override func configureCircle(_ circle: Circle) {
        circle.strokeColor = Color(UIColor.black)
        circle.fillColor = nil
    }
    
    func upTapped(_ sender: AnyObject) {
        mouseRect += 4.0
    }
    
    func downTapped(_ sender: AnyObject) {
        mouseRect = max(mouseRect - 4.0, 1.0)
    }
}
