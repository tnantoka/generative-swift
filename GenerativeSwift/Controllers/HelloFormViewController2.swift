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
    var circleItem: UIBarButtonItem!
    
    var strokeColor: Color {
        return Color(UIColor(white: 0, alpha: 0.25))
//        return C4Pink.colorWithAlpha(0.25)
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
        circleItem = UIBarButtonItem(title: "Auto (Circle)", style: .Plain, target: self, action: #selector(circleTapped))
        let flexible = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        toolbarItems = [flexible, autoItem, flexible, circleItem, flexible]
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: true)
        navigationController?.interactivePopGestureRecognizer?.enabled = false
    }
    
    override func viewDidAppear(animated: Bool) {
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
            let y = Double(random(min: 84, max: Int(canvas.height * 0.25)))
            drawRandom(x, y: y)
            x = nextX(x)
        }
    }
    
    func circleTapped(sender: AnyObject) {
        clear()
        
//        var x = 10.0
//        var y = 84.0
//        let vx = 4.0
//        let vy = 2.0
//        (1...10).forEach { i in
//            x += vx * Double(i)
//            y += vy * Double(i)
//            drawRandom(x, y: positionWithNoise(y))
//        }
        
        let y = canvas.height
        let vx = 4.0
        var x = Double(random(min: 10, max: 50))
        (1...12).forEach { i in
            let _ = nextX(x)
            drawRandom(x, y: y)
            x += vx * Double(i)
        }
    }
    
    func drawRandom(x: Double, y: Double) {
        (0..<random(min: 10, max: 30)).forEach { _ in
            let randomX = positionWithNoise(x)
            point = Point(randomX, y)
            (0..<random(min: 1, max: 4)).forEach { _ in
                updateCircle()
            }
        }
    }
    
    func positionWithNoise(pos: Double) -> Double {
        let min = random(min: 85, max: 90)
        let max = random(min: 110, max: 115)
        return pos * Double(random(min: min, max: max)) / 100.0
    }
    
    func nextX(x: Double) -> Double {
        let min = random(min: 55, max: 65)
        let max = random(min: 80, max: 90)
        return x * Double(random(min: min, max: max)) / 100.0
    }
}
