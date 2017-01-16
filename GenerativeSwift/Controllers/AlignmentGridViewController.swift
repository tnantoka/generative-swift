//
//  AlignmentGridViewController.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/17/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class AlignmentGridViewController: BaseCanvasController {
    var form = [Shape]()
    var point = Point(0, 0)
    var randomSeed = time(nil)
    
    let tileCountX = 10
    
    var lineCap: Line.LineCap {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return .Butt
        case 1:
            return .Round
        case 2:
            return .Square
        default:
            fatalError()
        }
    }

    let segmentedControl = UISegmentedControl(items: ["1", "2", "3"])

    override init() {
        super.init()
        title = "Alignment in a Grid"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.sizeToFit()
        segmentedControl.selectedSegmentIndex = 0
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
            self.updateForm()
        }
        let _ = canvas.addTapGestureRecognizer { locations, center, state in
            self.randomSeed = time(nil)
            self.updateForm()
        }
        point = canvas.center
        updateForm()
    }
    
    func updateForm() {
        srand48(randomSeed)

        for shape in form {
            shape.removeFromSuperview()
        }
        form = [Shape]()
        
        let tileSize = canvas.width / Double(tileCountX)
        let tileCountY = Int(canvas.height / tileSize)
        
        (0..<tileCountY).forEach { gridY in
            (0..<tileCountX).forEach { gridX in
                let pos = Point(
                    Double(gridX) * tileSize,
                    Double(gridY) * tileSize
                )
                let line: Line

                if drand48() > 0.5 {
                    line = Line([
                        pos,
                        Point(pos.x + tileSize, pos.y + tileSize),
                    ])
                    line.lineWidth = point.x / 20
                } else {
                    line = Line([
                        Point(pos.x, pos.y + tileSize),
                        Point(pos.x + tileSize, pos.y),
                    ])
                    line.lineWidth = point.y / 20
                }
                line.lineCap = lineCap
                canvas.add(line)
                form.append(line)
            }
        }
    }
    
    func segmentedControlChanged(_ sender: AnyObject) {
        updateForm()
    }
}
