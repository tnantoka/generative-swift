//
//  ComplexModulesGridViewController.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/21/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class ComplexModulesGridViewController: BaseCanvasController {
    var form = [Shape]()
    var point = Point(0, 0)
    var randomSeed = time(nil)
    
    let tileCountX = 6
    
    var tileSize: Double {
        return canvas.width / Double(tileCountX)
    }
    var tileCountY: Int {
        return Int(ceil(canvas.height / tileSize))
    }
    
    override init() {
        super.init()
        title = "Complex Modules in a Grid"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        let _ = canvas.addPanGestureRecognizer { locations, center, translation, velocity, state in
            self.point = center
            self.updateForm()
        }
        let _ = canvas.addTapGestureRecognizer { locations, center, state in
            self.randomSeed = time(nil)
            self.updateForm()
        }
        point = canvas.center
        updateForm()
    }
    
    func updateForm() {
        srand48(randomSeed)

        for shape in form {
            shape.removeFromSuperview()
        }
        form = [Shape]()

        let endSize = map(point.x, min: 0, max: canvas.size.width, toMin: tileSize / 2, toMax: 0)
        let endOffset = map(point.y, min: 0, max: canvas.size.height, toMin: 0, toMax: (tileSize - endSize) / 2)
        
        let circleCount = Int(point.x / 30 + 1)
        (0..<tileCountY).forEach { gridY in
            (0..<tileCountX).forEach { gridX in
                let toggle = arc4random() % 4
                (0..<circleCount).forEach { i in
                    let circle = Circle(frame: Rect(0, 0, 0, 0))
                    circle.strokeColor = Color(UIColor(white: 0.5, alpha: 1.0))
                    circle.fillColor = nil
                    circle.lineWidth = 1.0
                    canvas.add(circle)
                    form.append(circle)
                    
                    let maxI = max(Double(circleCount) - 1, 1)
                    let diameter = map(Double(i), min: 0, max: maxI, toMin: tileSize, toMax: endSize)
                    let offset = map(Double(i), min: 0, max: maxI, toMin: 0, toMax: endOffset)
                    
                    var x = Double(gridX) * tileSize + tileSize / 2
                    var y = Double(gridY) * tileSize + tileSize / 2
                    
                    switch toggle {
                    case 0:
                        x += offset
                    case 1:
                        x -= offset
                    case 2:
                        y += offset
                    case 3:
                        y -= offset
                    default:
                        fatalError()
                    }
                    
                    let pos = Point(x, y)
                    
                    circle.frame.size = Size(diameter, diameter)
                    circle.center = pos
                }
            }
        }

//        (0..<tileCountY).forEach { gridY in
//            (0..<tileCountX).forEach { gridX in
//                let circle = form[gridY * tileCountX + gridX]
//                
//                let shiftX = randomX(point.x) / 20
//                let shiftY = randomX(point.x) / 20
//                
//            }
//        }
    }
    
    func randomX(_ x: Double) -> Double {
        let sign = arc4random() % 2 == 0 ? 1.0 : -1.0
        return sign * x * Double(arc4random() % 100) / 100
    }
}
