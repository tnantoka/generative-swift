//
//  TableViewController.swift
//  GenerativeSwift
//
//  Created by Tatsuya Tobioka on 4/16/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import RFAboutView_Swift

class TableViewController: UITableViewController {

    let sections = [
        "Colour",
        "Form"
    ]
    let rows: [[BaseCanvasController]] = [
        [
            HelloColourViewController(),
            ColourSpectrumViewController(),
            ColourSpectrumCircleViewController(),
            ColourSpectrumCircleViewController2(),
            ColourPaletteInterpolationViewController(),
            // ColourPalettePicturesViewController(), // TODO
            ColourPaletteRulesViewController(),
            // Colour Palette by Rules 2 // TODO
            // Colour Palette by Rules 3 // TODO
            // Colour Palette by Rules 4 // TODO
        ],
        [
            HelloFormViewController(),
            HelloFormViewController2(),
            HelloFormViewController3(),
            AlignmentGridViewController(),
            // AlignmentGridViewController2(), // TODO
            // AlignmentGridViewController3(), // TODO
            // AlignmentGridViewController4(), // TODO
            MovementGridViewController(),
            MovementGridViewController2(),
            // MovementGridViewController3(), // TODO
            // MovementGridViewController4(), // TODO
            ComplexModulesGridViewController(),
            // ComplexModulesGridViewController2() // TODO,
            // ComplexModulesGridViewController3() // TODO,
            // ComplexModulesGridViewController4() // TODO,
            // ComplexModulesGridViewController5() // TODO,
            StupidAgentViewController(),
            // StupidAgentViewController2(), // TODO
            IntelligentAgentViewController(),
            // IntelligentAgentViewController2(), // TODO
        ],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        title = "Generative Swift"
        tableView.rowHeight = 88.0
        
        let infoButton = UIButton(type: .InfoLight)
        infoButton.addTarget(self, action: #selector(infoTapped), forControlEvents: .TouchUpInside)
        let infoItem = UIBarButtonItem(customView: infoButton)
        navigationItem.leftBarButtonItem = infoItem
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(true, animated: true)
        navigationController?.interactivePopGestureRecognizer?.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rows[section].count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        let row = rows[indexPath.section][indexPath.row]
        cell.textLabel?.text = row.title
        cell.imageView?.image = row.thumbnail
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = rows[indexPath.section][indexPath.row]
        navigationController?.pushViewController(row, animated: true)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func infoTapped(sender: AnyObject) {
        let aboutController = RFAboutViewController(
            appName: nil,
            appVersion: nil,
            appBuild: nil,
            copyrightHolderName: "tnantoka",
            contactEmail: nil,
            contactEmailTitle: nil,
            websiteURL: NSURL(string: "https://github.com/tnantoka/generative-swift"),
            websiteURLTitle: nil,
            pubYear: "2016")
        
        let navController = UINavigationController(rootViewController: aboutController)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(doneTapped))
        navController.navigationItem.leftBarButtonItem = doneItem

        presentViewController(navController, animated: true, completion: nil)
    }
    
    func doneTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
