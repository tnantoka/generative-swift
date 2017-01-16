//
//  ColourPaletteRulesViewController.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/16/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class ColourPaletteRulesViewController: BaseCanvasController {
    var grid = [Rectangle]()
    var point = Point(0, 0)
    
    var hueValues = [Double]()
    var saturationValues = [Double]()
    var brightnessValues = [Double]()
    
    let maxTileCountX = 50
    let maxTileCountY = 10
    
    let segmentedControl = UISegmentedControl(items: ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"])
    
    override init() {
        super.init()
        title = "Colour Palette by Rules"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.sizeToFit()
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
        let item = UIBarButtonItem(customView: segmentedControl)
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
            self.updateGrid()
        }
        let _ = canvas.addTapGestureRecognizer { locations, center, state in
            self.point = center
            self.updateGrid()
        }
        point = canvas.center
        changeColors()
        updateGrid()
    }
    
    func updateGrid() {
        for rectangle in grid {
            rectangle.removeFromSuperview()
        }
        grid = [Rectangle]()
        
        let tileCountX = Int(map(point.x, min: 0, max: canvas.width, toMin: 1, toMax: Double(maxTileCountX)))
        let tileCountY = Int(map(point.y, min: 0, max: canvas.height, toMin: 1, toMax: Double(maxTileCountY)))
        
        let tileWidth = canvas.width / Double(tileCountX)
        let tileHeight = canvas.height / Double(tileCountY)
        
        var counter = 0
        (0..<tileCountY).forEach { gridY in
            (0..<tileCountX).forEach { gridX in
                let x = Double(gridX) * tileWidth
                let y = Double(gridY) * tileHeight
                let index = counter % Int(Double(tileCountX) * 0.8) // FIXME
                
                let rectangle = Rectangle(frame: Rect(x, y, tileWidth, tileHeight))
                rectangle.strokeColor = nil
                rectangle.corner = Size(0, 0)
                
                let hue = hueValues[index]
                let saturation = saturationValues[index]
                let brightness = brightnessValues[index]
                rectangle.fillColor = Color(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
                
                canvas.add(rectangle)
                grid.append(rectangle)
                
                counter += 1
            }
        }
    }
    
    func changeColors() {
        hueValues = [Double]()
        saturationValues = [Double]()
        brightnessValues = [Double]()
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            (0..<maxTileCountX).forEach { i in
                if i % 2 == 0 {
                    hueValues.append(192 / 360.0)
                    saturationValues.append(Double(random(min: 0, max: 100)) / 100.0)
                    brightnessValues.append(Double(random(min: 10, max: 100)) / 100.0)
                } else {
                    hueValues.append(273 / 360.0)
                    saturationValues.append(Double(random(min: 0, max: 100)) / 100.0)
                    brightnessValues.append(Double(random(min: 10, max: 90)) / 100.0)
                }
            }
        case 1:
            (0..<maxTileCountX).forEach { _ in
                hueValues.append(Double(random(min: 0, max: 360)) / 360.0)
                saturationValues.append(Double(random(min: 0, max: 100)) / 100.0)
                brightnessValues.append(Double(random(min: 0, max: 100)) / 100.0)
            }
        case 2:
            (0..<maxTileCountX).forEach { _ in
                hueValues.append(Double(random(min: 0, max: 360)) / 360.0)
                saturationValues.append(Double(random(min: 0, max: 100)) / 100.0)
                brightnessValues.append(1.0)
            }
        case 3:
            (0..<maxTileCountX).forEach { _ in
                hueValues.append(Double(random(min: 0, max: 360)) / 360.0)
                saturationValues.append(1.0)
                brightnessValues.append(Double(random(min: 0, max: 100)) / 100.0)
            }
        case 4:
            (0..<maxTileCountX).forEach { _ in
                hueValues.append(0)
                saturationValues.append(0)
                brightnessValues.append(Double(random(min: 0, max: 100)) / 100.0)
            }
        case 5:
            (0..<maxTileCountX).forEach { _ in
                hueValues.append(195 / 360.0)
                saturationValues.append(1.0)
                brightnessValues.append(Double(random(min: 0, max: 100)) / 100.0)
            }
        case 6:
            (0..<maxTileCountX).forEach { _ in
                hueValues.append(195 / 360.0)
                saturationValues.append(Double(random(min: 0, max: 100)) / 100.0)
                brightnessValues.append(1.0)
            }
        case 7:
            (0..<maxTileCountX).forEach { _ in
                hueValues.append(Double(random(min: 0, max: 180)) / 360.0)
                saturationValues.append(Double(random(min: 80, max: 100)) / 100.0)
                brightnessValues.append(Double(random(min: 50, max: 90)) / 100.0)
            }
        case 8:
            (0..<maxTileCountX).forEach { _ in
                hueValues.append(Double(random(min: 180, max: 360)) / 360.0)
                saturationValues.append(Double(random(min: 80, max: 100)) / 100.0)
                brightnessValues.append(Double(random(min: 50, max: 90)) / 100.0)
            }
        case 9:
            (0..<maxTileCountX).forEach { i in
                if i % 2 == 0 {
                    hueValues.append(Double(random(min: 0, max: 360)) / 360.0)
                    saturationValues.append(1.0)
                    brightnessValues.append(Double(random(min: 0, max: 100)) / 100.0)
                } else {
                    hueValues.append(195 / 360.0)
                    saturationValues.append(Double(random(min: 0, max: 100)) / 100.0)
                    brightnessValues.append(1.0)
                    
                }
            }
        default:
            fatalError()
        }
    }
    
    func segmentedControlChanged(_ sender: AnyObject) {
        changeColors()
        updateGrid()
    }
}
