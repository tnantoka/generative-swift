//
//  DrawingBrushViewController.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 5/3/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class DrawingBrushViewController: DensityAgentViewController {
    
    var lineLength = 0.0
    var angle = 0.0
    var angleSpeed = 0.0
    var color = Color()

    let defaultColor = Color(red: 181, green: 157, blue: 0, alpha: 1)
    
    override init() {
        super.init()
        title = "Drawing with Animated Brushes"
        trash = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colorItems: [UIBarButtonItem] = (1...5).map { i in
            let item = UIBarButtonItem(title: "\(i)", style: .Plain, target: self, action: #selector(colorTapped))
            item.tag = i
            return item
        }
        
        let arrowItems: [UIBarButtonItem] = ["↑", "↓", "←", "→"].enumerate().map { i, t in
            let item = UIBarButtonItem(title: t, style: .Plain, target: self, action: #selector(arrowTapped))
            item.tag = i
            return item
        }
        
        let auto = UIBarButtonItem(title: "Auto", style: .Plain, target: self, action: #selector(autoTapped))
        let reverse = UIBarButtonItem(title: "Reverse", style: .Plain, target: self, action: #selector(reverseTapped))
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        toolbarItems = [flexible, auto, flexible, reverse, flexible] + colorItems + [flexible] + arrowItems + [flexible]
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        start()
    }
    
    override func setup() {
        super.setup()
    }
    
    override func draw() {
        guard mousePressed else { return }
        drawLine()
    }
    
    func drawLine() {
        let x = point.x + cos(degToRad(angle)) * lineLength
        let y = point.y + sin(degToRad(angle)) * lineLength
        let line = Line(begin: point, end: Point(x, y))
        line.strokeColor = color
        canvas.add(line)

        angle += angleSpeed
    }
    
    override func clearPoints() {
        changeLength()
        angle = 0.0
        angleSpeed = 1.0
        color = defaultColor
    }
    
    func reverseTapped(sender: AnyObject) {
        reverse()
    }
    
    func colorTapped(sender: AnyObject) {
        changeColor(sender.tag)
    }

    func arrowTapped(sender: AnyObject) {
        switch sender.tag {
        case 0?:
            lineLength += 5
        case 1?:
            lineLength -= 5
        case 2?:
            angleSpeed -= 0.5
        case 3?:
            angleSpeed += 0.5
        default:
            fatalError()
        }
    }
    
    func changeLength() {
        lineLength = Double(random(min: 50, max: 160))
    }
    
    func changeColor(tag: Int?) {
        switch tag {
        case 1?:
            color = defaultColor
        case 2?:
            color = Color(red: 0, green: 130, blue: 164, alpha: 1)
        case 3?:
            color = Color(red: 87, green: 35, blue: 129, alpha: 1)
        case 4?:
            color = Color(red: 197, green: 0, blue: 123, alpha: 1)
        case 5?:
            color = Color(
                red: random(min: 0, max: 255),
                green: random(min: 0, max: 255),
                blue: random(min: 0, max: 255),
                alpha: Double(random(min: 80, max: 150)) / 255.0
            )
        default:
            fatalError()
        }
    }
    
    func reverse() {
        angle += 180
        angleSpeed *= -1
    }
    
    func autoTapped(sender: AnyObject) {
        clear()
        mousePressed = false
        point = canvas.center
        
        let randomColor = random(min: 0, max: 3) != 0 ? true : false
        let randomLength = random(min: 0, max: 3) != 0 ? true : false
        let randomSpeed = random(min: 0, max: 3) == 0 ? true : false
        let decrease = (!randomLength && random(min: 0, max: 4) == 0) ? true : false
        let withReverse = random(min: 0, max: 5) == 0 ? true : false
        
        changeColor(random(min: 1, max: 6))
        
        let count = random(min: 1, max: 50)
        (0..<count).forEach { i in
            
            let steps = random(min: 10, max: 40)
            (0..<steps).forEach { j in
                if randomColor && j % 5 == 0 {
                    changeColor(random(min: 1, max: 6))
                }
                
                if randomLength && j % 10 == 0 {
                    changeLength()
                }
                
                if randomSpeed && j % 15 == 0 {
                    angleSpeed += Double(random(min: -100, max: 100)) / 100
                }
                
                drawLine()
            }

            if decrease {
                lineLength -= Double(random(min: 0, max: min(4, Int(lineLength))))
            }
            
            if withReverse && i % 3 == 0 {
                reverse()
            }
        }
        
    }
}
