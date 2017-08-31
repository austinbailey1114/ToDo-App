//
//  TableViewController.swift
//  ToDoApp
//
//  Created by Austin Bailey on 8/30/17.
//  Copyright © 2017 Austin Bailey. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var keepContext: NSManagedObjectContext?
    var items: NSManagedObject?
    var currentDate: String?
    var currentDay: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        NavigationViewController.keepContext = context
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            if results.count > 0 {
                NavigationViewController.items = results[0]
            }
            else {
                let initialList = NSEntityDescription.insertNewObject(forEntityName: "Items", into: context)
                initialList.setValue([String](), forKey: "toDo")
                initialList.setValue([String](), forKey: "done")
                
                do {
                    try context.save()
                }
                
                catch {
                    
                }
                
            }
            
        }
            
        catch {
            //add code
        }
        
        keepContext = NavigationViewController.keepContext
        items = NavigationViewController.items

        let toDo = items!.value(forKey: "toDo") as! [String]
        if toDo.count > 0 {
            let firstItem = toDo[0].components(separatedBy: "`")
        }
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        items = NavigationViewController.items
        let toDo = items!.value(forKey: "toDo") as! [String]
        return toDo.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else {
            fatalError("Fatal error")
        }
        let toDo = items!.value(forKey: "toDo") as! [String]
        let item = toDo[indexPath.row]
        let components = item.components(separatedBy: "`")
        
        cell.itemLabel.text! = components[0]
        cell.timeLabel.text! = components[1]
        cell.dayLabel.text! = components[2]
        cell.dateLabel.text! = components[3]
        if cell.itemLabel.text! == "0" && cell.timeLabel.text! == "0" {
            cell.itemLabel.isHidden = true
            cell.timeLabel.isHidden = true
            cell.doneSwitch.isHidden = true
        }
        else {
            cell.dayLabel.isHidden = true
        }

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
