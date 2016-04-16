//
//  HelloColourViewController.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/16/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class HelloColourViewController: CanvasController {
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Hello Colour"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }

    override func setup() {
        let rectangle = Rectangle(frame: Rect(0, 0, 0, 0))
        rectangle.strokeColor = nil
        canvas.add(rectangle)
        
        let ratio = canvas.height / canvas.width
        
        canvas.addPanGestureRecognizer { locations, center, translation, velocity, state in
            rectangle.frame.width = center.x
            rectangle.frame.height = center.x * ratio
            rectangle.center = self.canvas.center

            let hue = center.y / self.canvas.height
            rectangle.fillColor = Color(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            self.canvas.backgroundColor = Color(hue: 1.0 - hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        }
    }
}
