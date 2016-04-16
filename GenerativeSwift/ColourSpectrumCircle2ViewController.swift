//
//  ColourSpectrumCircle2ViewController.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/16/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class ColourSpectrumCircle2ViewController: CanvasController {
    var circle = [Wedge]()
    let slider = UISlider()
    var point = Point(0, 0)
    
    let segments = [6, 12, 24, 45, 360]
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Colour Spectrum in a Circle 2"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShapeLayer.disableActions = true
    }
    
    override func setup() {
        navigationController?.toolbarHidden = false
        
        slider.frame = CGRectMake(0, 0, CGRectGetWidth(view.bounds) - 40, 34)
        slider.maximumValue = Float(segments.indices.last ?? 0)
        slider.minimumValue = 0
        slider.continuous = false
        slider.addTarget(self, action: #selector(sliderChanged), forControlEvents: .ValueChanged)
        let item = UIBarButtonItem(customView: slider)
        let flexible = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        toolbarItems = [flexible, item, flexible]
        
        canvas.addPanGestureRecognizer { locations, center, translation, velocity, state in
            self.point = center
            self.updateCircle()
        }
        canvas.addTapGestureRecognizer { locations, center, state in
            self.point = center
            self.updateCircle()
        }
        point = canvas.center
        updateCircle()
    }
    
    func updateCircle() {
        for wedge in circle {
            wedge.removeFromSuperview()
        }
        circle = [Wedge]()
        
        let segmentCount = segments[Int(slider.value)]
        let angleStep = 360.0 / Double(segmentCount)
        
        let radius = canvas.width * 0.4
        
        var start = 0.0
        angleStep.stride(through: 360.0, by: angleStep).forEach { angle in
            let end = degToRad(angle)
            let wedge = Wedge(center: canvas.center, radius: radius, start: start, end: end)
            wedge.strokeColor = nil
            let hue = angle / 360
            let saturation = point.x / canvas.width
            let brightness = point.y / canvas.height
            wedge.fillColor = Color(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
            
            start = end
            canvas.add(wedge)
            circle.append(wedge)
        }
    }
    
    func sliderChanged(sender: AnyObject) {
        slider.value = round(slider.value)
        updateCircle()
    }
}
