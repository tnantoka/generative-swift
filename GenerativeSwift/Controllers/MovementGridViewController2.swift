//
//  MovementGridViewController2.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/18/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class MovementGridViewController2: MovementGridViewController {
    
    var formBack = [Shape]()
    var formFore = [Shape]()
    
    let segmentedControl = UISegmentedControl(items: ["0", "1", "2", "3"])

    var backColor = Color()
    var foreColor = Color()

    var alphaBack = 0.0
    var alphaFore = 0.0

    var backSize = 0.0
    var foreSize = 0.0

    override init() {
        super.init()
        title = "Movement in a Grid 2"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: true)
    }

    override func setup() {
        segmentedControl.sizeToFit()
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), forControlEvents: .ValueChanged)
        let item = UIBarButtonItem(customView: segmentedControl)

        let up = UIBarButtonItem(title: "↑", style: .Plain, target: self, action: #selector(upTapped))
        let down = UIBarButtonItem(title: "↓", style: .Plain, target: self, action: #selector(downTapped))
        let left = UIBarButtonItem(title: "←", style: .Plain, target: self, action: #selector(leftTapped))
        let right = UIBarButtonItem(title: "→", style: .Plain, target: self, action: #selector(rightTapped))

        let flexible = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        toolbarItems = [flexible, item, flexible, up, down, left, right, flexible]

        changeColor()
        super.setup()
    }
    
    override func createForm() {
        (0..<tileCountY).forEach { gridY in
            (0..<tileCountX).forEach { gridX in
                let circle = Circle(frame: Rect(0, 0, 0, 0))
                circle.strokeColor = nil
                canvas.add(circle)
                formBack.append(circle)
                
                let circleFore = Circle(frame: Rect(0, 0, 0, 0))
                circleFore.strokeColor = nil
                canvas.add(circleFore)
                formFore.append(circleFore)
            }
        }
    }
    
    override func updateForm() {
        srand(randomSeed)

        (0..<tileCountY).forEach { gridY in
            (0..<tileCountX).forEach { gridX in
                let back = formBack[gridY * tileCountX + gridX]
                let fore = formFore[gridY * tileCountX + gridX]
                
                let shiftX = randomX(1) * point.x / 20
                let shiftY = randomX(1) * point.y / 20
                
                let pos = Point(
                    Double(gridX) * tileSize + tileSize / 2,
                    Double(gridY) * tileSize + tileSize / 2
                )
                let shiftPos = Point(
                    pos.x + shiftX,
                    pos.y + shiftY
                )
                
                back.frame.size = Size(backSize, backSize)
                back.center = shiftPos
                back.fillColor = backColor
                back.opacity = alphaBack

                fore.frame.size = Size(foreSize, foreSize)
                fore.center = pos
                fore.fillColor = foreColor
                fore.opacity = alphaFore
            }
        }
    }
    
    func segmentedControlChanged(sender: AnyObject) {
        changeColor()
        updateForm()
    }

    func upTapped(sender: AnyObject) {
        changeSize(0)
        updateForm()
    }

    func downTapped(sender: AnyObject) {
        changeSize(1)
        updateForm()
    }

    func leftTapped(sender: AnyObject) {
        changeSize(2)
        updateForm()
    }

    func rightTapped(sender: AnyObject) {
        changeSize(3)
        updateForm()
    }

    func changeSize(index: Int) {
        switch index {
        case 0:
            backSize += 2
        case 1:
            backSize = max(backSize - 2, 10)
        case 2:
            foreSize = max(foreSize - 2, 5)
        case 3:
            foreSize += 2
        default:
            fatalError()
        }
    }

    func changeColor() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            backColor = Color(UIColor.blackColor())
            foreColor = Color(UIColor.whiteColor())
            alphaBack = 1.0
            alphaFore = 1.0
            backSize = 20.0
            foreSize = 10.0
        case 1:
            backColor = Color(
                hue: 273 / 360.0,
                saturation: 73 / 100.0,
                brightness: 51 / 100.0,
                alpha: 1.0
            )
        case 2:
            foreColor = Color(
                hue: 323 / 360.0,
                saturation: 1.0,
                brightness: 77 / 100.0,
                alpha: 1.0
            )
        case 3:
            alphaBack = 0.5
            alphaFore = 0.5
        default:
            fatalError()
        }
    }
}
