//
//  MovementGridViewController.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/18/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class MovementGridViewController: BaseCanvasController {
    var form = [Shape]()
    var point = Point(0, 0)
    var randomSeed = time(nil)

    let tileCountX = 10
    
    var tileSize: Double {
        return canvas.width / Double(tileCountX)
    }
    var tileCountY: Int {
        return Int(ceil(canvas.height / tileSize))
    }
   
    override init() {
        super.init()
        title = "Movement in a Grid"
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
        point = Point(0, canvas.center.y)
        createForm()
        updateForm()
    }
    
    func createForm() {
        (0..<tileCountY).forEach { gridY in
            (0..<tileCountX).forEach { gridX in
                let circle = Circle(frame: Rect(0, 0, 0, 0))
                circle.strokeColor = Color(UIColor(white: 0.0, alpha: 0.5))
                circle.fillColor = nil
                canvas.add(circle)
                form.append(circle)
            }
        }
    }
    
    func updateForm() {
        srand48(randomSeed)

        (0..<tileCountY).forEach { gridY in
            (0..<tileCountX).forEach { gridX in
                let circle = form[gridY * tileCountX + gridX]

                let shiftX = randomX(point.x) / 20
                let shiftY = randomX(point.x) / 20

                let pos = Point(
                    Double(gridX) * tileSize + tileSize / 2 + shiftX,
                    Double(gridY) * tileSize + tileSize / 2 + shiftY
                )
                
                let size = point.y / 15

                circle.frame.size = Size(size, size)
                circle.center = pos
                circle.lineWidth = point.y / 60
            }
        }
    }
    
    func randomX(_ x: Double) -> Double {
        let sign = arc4random() % 2 == 0 ? 1.0 : -1.0
        return sign * x * Double(arc4random() % 100) / 100
    }
}
