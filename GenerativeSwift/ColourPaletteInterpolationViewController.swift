//
//  ColourPaletteInterpolationViewController.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/16/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class ColourPaletteInterpolationViewController: CanvasController {
    var grid = [Rectangle]()
    var point = Point(0, 0)

    var colorsLeft = [Color]()
    var colorsRight = [Color]()
    
    let maxTileCountX = 100
    let maxTileCountY = 10
    
    let segmentedControl = UISegmentedControl(items: ["HSB", "RGB"])

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Colour palette by interpolation"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShapeLayer.disableActions = true
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
        let flexible = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        toolbarItems = [flexible, item, flexible]

        canvas.addPanGestureRecognizer { locations, center, translation, velocity, state in
            self.point = center
            self.updateGrid()
        }
        canvas.addTapGestureRecognizer { locations, center, state in
            self.shakeColors()
            self.updateGrid()
        }
        point = canvas.center
        shakeColors()
        updateGrid()
    }
    
    func updateGrid() {
        for rectangle in grid {
            rectangle.removeFromSuperview()
        }
        grid = [Rectangle]()

        let tileCountX = Int(map(point.x, min: 0, max: canvas.width, toMin: 2, toMax: Double(maxTileCountX)))
        let tileCountY = Int(map(point.y, min: 0, max: canvas.height, toMin: 2, toMax: Double(maxTileCountY)))

        let tileWidth = canvas.width / Double(tileCountX)
        let tileHeight = canvas.height / Double(tileCountY)

        (0..<tileCountY).forEach { gridY in
            let col1 = colorsLeft[gridY]
            let col2 = colorsRight[gridY]
            
            (0..<tileCountX).forEach { gridX in
                let x = Double(gridX) * tileWidth
                let y = Double(gridY) * tileHeight
                let rectangle = Rectangle(frame: Rect(x, y, tileWidth, tileHeight))
                rectangle.strokeColor = nil
                rectangle.corner = Size(0, 0)
                
                let amount = map(Double(gridX), min: 0, max: Double(tileCountX) - 1, toMin: 0, toMax: 1)
                if segmentedControl.selectedSegmentIndex == 0 {
                    let hue = lerp(col1.hue, col2.hue, at: amount)
                    let saturation = lerp(col1.saturation, col2.saturation, at: amount)
                    let brightness = lerp(col1.brightness, col2.brightness, at: amount)
                    rectangle.fillColor = Color(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
                } else {
                    let red = lerp(col1.red, col2.red, at: amount)
                    let green = lerp(col1.green, col2.green, at: amount)
                    let blue = lerp(col1.blue, col2.blue, at: amount)
                    rectangle.fillColor = Color(red: red, green: green, blue: blue, alpha: 1.0)
                }
                
                canvas.add(rectangle)
                grid.append(rectangle)
            }
        }
    }
    
    func shakeColors() {
        colorsLeft = [Color]()
        colorsRight = [Color]()
        (0..<maxTileCountY).forEach { _ in
            colorsLeft.append(
                Color(
                    hue: Double(random(min: 0, max: 60)) /  360.0,
                    saturation: Double(random(min: 0, max: 100)) / 100.0,
                    brightness: 1.0,
                    alpha: 1.0
                )
            )
            colorsRight.append(
                Color(
                    hue: Double(random(min: 160, max: 190)) / 360.0,
                    saturation: 1.0,
                    brightness: Double(random(min: 0, max: 100)) / 100.0,
                    alpha: 1.0
                )
            )
        }
    }
    
    func segmentedControlChanged(sender: AnyObject) {
        updateGrid()
    }
}
