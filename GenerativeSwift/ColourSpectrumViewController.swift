//
//  ColourSpectrumViewController.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/16/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class ColourSpectrumViewController: CanvasController {
    var grid = [Rectangle]()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Colour Spectrum"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        ShapeLayer.disableActions = true
        canvas.addPanGestureRecognizer { locations, center, translation, velocity, state in
            self.updateGrid(center)
        }
        canvas.addTapGestureRecognizer { locations, center, state in
            self.updateGrid(center)
        }
        updateGrid(canvas.center)
    }
    
    func updateGrid(point: Point) {
        for rectangle in grid {
            rectangle.removeFromSuperview()
        }
        grid = [Rectangle]()
        
        let stepX = point.x + 2
        let stepY = point.y + 2
        
        0.stride(to: canvas.height, by: stepY).forEach { y in
            0.stride(to: canvas.width, by: stepX).forEach { x in
                let rectangle = Rectangle(frame: Rect(x, y, stepX, stepY))
                rectangle.strokeColor = nil
                rectangle.corner = Size(0, 0)
                let hue = x / canvas.height
                let saturation = 1.0 - y / canvas.height
                rectangle.fillColor = Color(hue: hue, saturation: saturation, brightness: 1.0, alpha: 1.0)
                canvas.add(rectangle)
                grid.append(rectangle)
            }
        }
    }
}
