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
    
    var direction = Direction.south
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
                direction = .south
                reachedBorder = true
            } else if x >= canvas.width - 5 {
                direction = .west
                reachedBorder = true
            } else if y >= canvas.height - 5 {
                direction = .north
                reachedBorder = true
            } else if x <= 5 {
                direction = .east
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
                    line.strokeColor = Color(UIColor.black)
                    line.lineWidth = 3
                    canvas.add(line)
                    lines.append(line)
                }
                crossX = x
                crossY = y
            }
        }
    }
    
    override func clearPoints() {
        point = canvas.center
        x = point.x
        y = point.y
        angle = randomAngle()
        lines = [Line]()
    }

    func randomAngle() -> Double {
        let angle = (Double(random(min: -angleCount, max: angleCount)) + 0.5) * 90 / Double(angleCount)
        switch direction {
        case .north:
            return angle - 90
        case .east:
            return angle
        case .south:
            return angle + 90
        case .west:
            return angle + 180
        default:
            fatalError()
        }
    }
}
