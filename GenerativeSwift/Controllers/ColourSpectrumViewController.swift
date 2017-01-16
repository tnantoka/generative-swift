//
//  ColourSpectrumViewController.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/16/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class ColourSpectrumViewController: BaseCanvasController {
    var grid = [Rectangle]()
    
    override init() {
        super.init()
        title = "Colour Spectrum"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setup() {
        let _ = canvas.addPanGestureRecognizer { locations, center, translation, velocity, state in
            self.updateGrid(center)
        }
        let _ = canvas.addTapGestureRecognizer { locations, center, state in
            self.updateGrid(center)
        }
        updateGrid(canvas.center)
    }
    
    func updateGrid(_ point: Point) {
        for rectangle in grid {
            rectangle.removeFromSuperview()
        }
        grid = [Rectangle]()
        
        let stepX = point.x + 2
        let stepY = point.y + 2
       
        stride(from: 0, to: canvas.height, by: stepY).forEach { y in
            stride(from: 0, to: canvas.width, by: stepX).forEach { x in
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
