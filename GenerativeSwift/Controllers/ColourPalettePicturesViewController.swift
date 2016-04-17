//
//  ColourPalettePicturesViewController.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/16/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class ColourPalettePicturesViewController: BaseCanvasController {
    override init() {
        super.init()
        title = "Colour Palette from Pictures"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
    }
}
