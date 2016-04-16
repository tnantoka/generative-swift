//
//  ColourPalettePicturesViewController.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/16/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class ColourPalettePicturesViewController: CanvasController {
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Colour Palette from Pictures"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShapeLayer.disableActions = true
    }
    
    override func setup() {
    }
}
