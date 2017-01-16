//
//  ColourSpectrumCircleViewController2.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/16/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class ColourSpectrumCircleViewController2: ColourSpectrumCircleViewController {
    
    override init() {
        super.init()
        title = "Colour Spectrum in a Circle 2"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func createShape(_ radius: Double, start: Double, end: Double) -> Shape {
        let wedge = Wedge(center: canvas.center, radius: radius, start: start, end: end)
        return wedge
    }
}
