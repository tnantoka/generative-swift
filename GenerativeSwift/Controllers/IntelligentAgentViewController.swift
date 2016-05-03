//
//  IntelligentAgentViewController.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/23/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class IntelligentAgentViewController: StupidAgentViewController {

    var lines = [Line]()
    
    var direction = Direction.South
    var angle = 0.0
    let angleCount = 7
    let minLength = 10.0
    
    var crossX = 0.0
    var crossY = 0.0
    
    override var step: Double {
        return 3.0
    }
    
    override init() {
        super.init()
        title = "Intelligent Agent"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw() {
        let speed = map(point.x, min: 0, max: canvas.width, toMin: 2, toMax: 100)
        
        (0..<Int(speed)).forEach { _ in
            x += cos(degToRad(angle)) * step
            y += sin(degToRad(angle)) * step
            
            var reachedBorder = false
            if y <= 5 {
                direction = .South
                reachedBorder = true
            } else if x >= canvas.width - 5 {
                direction = .West
                reachedBorder = true
            } else if y >= canvas.height - 5 {
                direction = .North
                reachedBorder = true
            } else if x <= 5 {
                direction = .East
                reachedBorder = true
            }
            
            var crossedPath = false
            for line in lines {
                if line.contains(Point(x, y)) {
                    crossedPath = true
                    break
                }
            }

            if (crossedPath || reachedBorder) {
                angle = randomAngle()
                let dist = distance(Point(x, y), rhs: Point(crossX, crossY))
                if dist >= minLength {
                    let line = Line(begin: Point(x, y), end: Point(crossX, crossY))
                    line.strokeColor = Color(UIColor.blackColor())
                    line.lineWidth = 3
                    canvas.add(line)
                    lines.append(line)
                }
                crossX = x
                crossY = y
            }
        }
    }
    
    override func clear() {
        super.clear()
        point = canvas.center
        x = point.x
        y = point.y
        angle = randomAngle()
        lines = [Line]()
    }

    func randomAngle() -> Double {
        let angle = (Double(random(min: -angleCount, max: angleCount)) + 0.5) * 90 / Double(angleCount)
        switch direction {
        case .North:
            return angle - 90
        case .East:
            return angle
        case .South:
            return angle + 90
        case .West:
            return angle + 180
        default:
            fatalError()
        }
    }
}
