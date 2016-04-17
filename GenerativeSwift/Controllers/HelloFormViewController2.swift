//
//  HelloFormViewController2.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/16/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class HelloFormViewController2: HelloFormViewController {

    var autoItem: UIBarButtonItem!
    
    var strokeColor: Color {
        return Color(UIColor(white: 0, alpha: 0.25))
    }
    
    override init() {
        super.init()
        title = "Hello Form 2"
        trash = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        autoItem = UIBarButtonItem(title: "Auto", style: .Plain, target: self, action: #selector(autoTapped))
        let flexible = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        toolbarItems = [flexible, autoItem, flexible]
    }

    override func viewWillAppear(animated: Bool) {
        navigationController?.setToolbarHidden(false, animated: true)
    }

    override func createForm(circleResolution: Int, radius: Double, angle: Double) {
        let points = (0...circleResolution).map { i in
            return circlePoint(i, angle: angle, radius: radius)
        }
        let polygon = Polygon(points)
        polygon.strokeColor = strokeColor
        polygon.lineWidth = 2
        canvas.add(polygon)
    }
    
    func autoTapped(sender: AnyObject) {
        clear()
        
        var x = nextX(canvas.width)
        let min = Double(random(min: 10, max: 30))
        while x > min {
            drawRandom(x)
            x = nextX(x)
        }
    }
    
    func drawRandom(x: Double) {
        let y = Double(random(min: 84, max: Int(canvas.height * 0.3)))
        
        (0..<random(min: 10, max: 30)).forEach { _ in
            let randomX = x * Double(random(min: 90, max: 110)) / 100.0
            point = Point(randomX, y)
            updateCircle()
        }
    }
    
    func nextX(x: Double) -> Double {
        return x * Double(random(min: 65, max: 90)) / 100.0
    }
}
