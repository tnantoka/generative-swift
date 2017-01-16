//
//  BaseCanvasController.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/16/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import C4
import SafariServices

class BaseCanvasController: UIViewController {

    var trash = false
    
    lazy var thumbnail: UIImage? = {
        return UIImage(named: self.name) ?? UIImage(named: "\(self.name).jpg")
    }()
    
    lazy var name: String = {
        return self.controllerName
            .replacingOccurrences(of: "ViewController", with: "")
    }()
    
    lazy var controllerName: String = {
        return NSStringFromClass(type(of: self)).replacingOccurrences(of: "GenerativeSwift.", with: "")
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let trashItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashTapped))
        let actionItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionTapped))
        var items = [actionItem]
        if trash {
            items.append(trashItem)
        }
        navigationItem.rightBarButtonItems = items
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func trashTapped(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "Clear Canvas", message: "Are You Sure?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in self.clear() })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func actionTapped(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "Actions", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Save as an Image", style: .default) { _ in self.save() })
        alertController.addAction(UIAlertAction(title: "Source Code", style: .default) { _ in self.github() })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func clear() {
        for v in canvas.view.subviews {
            v.removeFromSuperview()
        }
    }
    
    func save() {
        let size = CGSize(width: canvas.width, height: canvas.height)
        
        let opaque = true
        let scale: CGFloat = 0.0
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        
        let context = UIGraphicsGetCurrentContext()!
        view.layer.render(in: context)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
    
    func github() {
        guard let url = URL(string: "https://github.com/tnantoka/generative-swift/blob/master/GenerativeSwift/Controllers/\(controllerName).swift") else { return }
        let safariController = SFSafariViewController(url: url)
        safariController.title = title
        navigationController?.pushViewController(safariController, animated: true)
    }
    
    // MARK: - C4.CanvasController
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        canvas.backgroundColor = C4Grey
        ShapeLayer.disableActions = true
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clear()
    }
    
    func setup() {
    }
}
