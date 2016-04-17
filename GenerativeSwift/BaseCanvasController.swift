//
//  BaseCanvasController.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/16/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4

class BaseCanvasController: CanvasController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ShapeLayer.disableActions = true
        
        let trash = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: #selector(trashTapped))
        let action = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(actionTapped))
        navigationItem.rightBarButtonItems = [trash, action]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func trashTapped(sender: AnyObject) {
        for v in canvas.view.subviews {
            v.removeFromSuperview()
        }
    }
    
    func actionTapped(sender: AnyObject) {
        let size = CGSize(width: canvas.width, height: canvas.height)
        
        let opaque = true
        let scale: CGFloat = 0.0
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        
        let context = UIGraphicsGetCurrentContext()!
        view.layer.renderInContext(context)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.presentViewController(activityController, animated: true, completion: nil)
    }
}
