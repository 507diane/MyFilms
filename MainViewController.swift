//
//  MainViewController.swift
//  MyFilms
//
//  Created by Diane Christy on 10/21/15.
//  Copyright © 2015 Diane Christy. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class MainViewController: UITableViewController {
    
    var filmArray = [NSManagedObject]()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loaddb()
    }
    func loaddb()
    {
        let appDelegate =
        UIApplication.sharedApplication() .delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName:"Films")
        
        var error: NSError?
        
        do {
            let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as?
                [NSManagedObject]
            if let results = fetchedResults {
                filmArray = results
                tableView.reloadData()
            } else {
                print("Could not fetch \(error), \(error!.userInfo)")
            }
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filmArray.count
        //return 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =
        tableView.dequeueReusableCellWithIdentifier("Cell")
            as UITableViewCell!
        
        let person = filmArray[indexPath.row]
        cell.textLabel?.text = person.valueForKey("film") as! String?
        cell.detailTextLabel?.text = ">>"
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print("You selected cell #\(indexPath.row)")
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            let context = appDelegate.managedObjectContext
            context.deleteObject(filmArray[indexPath.row])
            var error: NSError? = nil
            do {
                try context.save()
                loaddb()
            } catch let error1 as NSError {
                error = error1
                print("Unresolved error \(error)")
                abort()
            }
            
            // Delete the row from the data source
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        //} else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "UpdateFilms" {
            if let destination = segue.destinationViewController as?
                ViewController {
                    if let SelectIndex = tableView.indexPathForSelectedRow?.row {
                        let selectedDevice:NSManagedObject = filmArray[SelectIndex] as
                        NSManagedObject
                        destination.filmdb = selectedDevice
                    }
            }
        }
    }
    
    
}
