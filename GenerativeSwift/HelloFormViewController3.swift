//
//  HelloFormViewController3.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/16/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class HelloFormViewController3: HelloFormViewController2 {

    override var strokeColor: Color {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return C4Blue.colorWithAlpha(0.1)
        case 1:
            return C4Pink.colorWithAlpha(0.1)
        case 2:
            return C4Purple.colorWithAlpha(0.1)
        default:
            fatalError()
        }
    }
    
    let segmentedControl = UISegmentedControl(items: ["Blue", "Pink", "Purple"])

    override init() {
        super.init()
        title = "Hello Form 3"
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
        let item = UIBarButtonItem(customView: segmentedControl)
        let flexible = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        toolbarItems = [flexible, item, flexible]
        
        super.setup()
    }
}
