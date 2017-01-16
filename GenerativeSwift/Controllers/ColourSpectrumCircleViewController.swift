//
//  ColourSpectrumCircleViewController.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/16/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class ColourSpectrumCircleViewController: BaseCanvasController {
    var circle = [Shape]()
    var point = Point(0, 0)
    
    let slider = UISlider()
    let segments = [6, 12, 24, 45, 360]
    
    override init() {
        super.init()
        title = "Colour Spectrum in a Circle"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 40, height: 34)
        slider.maximumValue = Float(segments.indices.last ?? 0)
        slider.minimumValue = 0
        slider.isContinuous = false
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        let item = UIBarButtonItem(customView: slider)
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarItems = [flexible, item, flexible]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: true)
    }
    
    override func setup() {
        let _ = canvas.addPanGestureRecognizer { locations, center, translation, velocity, state in
            self.point = center
            self.updateCircle()
        }
        let _ = canvas.addTapGestureRecognizer { locations, center, state in
            self.point = center
            self.updateCircle()
        }
        point = Point(canvas.center.x * 1.5, canvas.center.y * 1.5)
        updateCircle()
    }
    
    func updateCircle() {
        for shape in circle {
            shape.removeFromSuperview()
        }
        circle = [Shape]()

        let segmentCount = segments[Int(slider.value)]
        let angleStep = 360.0 / Double(segmentCount)
        
        let radius = canvas.width * 0.4
        
        var start = 0.0
        stride(from: angleStep, through: 360.0, by: angleStep).forEach { angle in
            let end = degToRad(angle)

            let shape = createShape(radius, start: start, end: end)
            shape.strokeColor = nil
            let hue = angle / 360
            let saturation = point.x / canvas.width
            let brightness = point.y / canvas.height
            shape.fillColor = Color(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)

            start = end
            canvas.add(shape)
            circle.append(shape)
        }
    }
    
    func createShape(_ radius: Double, start: Double, end: Double) -> Shape {
        let point1 = Point(
            canvas.center.x + cos(start) * radius,
            canvas.center.y + sin(start) * radius
        )
        let point2 = Point(
            canvas.center.x + cos(end) * radius,
            canvas.center.y + sin(end) * radius
        )
        
        let triangle = Triangle([canvas.center, point1, point2])
        return triangle
    }
    
    func sliderChanged(_ sender: AnyObject) {
        slider.value = round(slider.value)
        updateCircle()
    }
}
