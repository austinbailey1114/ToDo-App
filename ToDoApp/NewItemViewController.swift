//
//  NewItemViewController.swift
//  ToDoApp
//
//  Created by Austin Bailey on 8/30/17.
//  Copyright © 2017 Austin Bailey. All rights reserved.
//

import UIKit
import CoreData

class NewItemViewController: UIViewController {

    @IBOutlet weak var itemInput: UITextField!
    @IBOutlet weak var timeInput: UITextField!
    @IBOutlet weak var dayofWeekInput: UITextField!
    @IBOutlet weak var dateInput: UITextField!
    
    var keepContext: NSManagedObjectContext?
    var items: NSManagedObject?
    
    override func viewDidLoad() {
        keepContext = NavigationViewController.keepContext
        items = NavigationViewController.items
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func saveButton(_ sender: UIButton) {
        //add to CoreData
        let newItem = itemInput.text! + "`" + timeInput.text! + "`" + dayofWeekInput.text! + "`" + dateInput.text!
        let previousItems = items!.value(forKey: "toDo") as! [String]
        let UpdatedItems = insertItem(previousItems: previousItems, newItem: newItem)
        items!.setValue(UpdatedItems, forKey: "toDo")
        do {
            try keepContext!.save()
        }
        catch {
            
        }
        
        itemInput.text! = ""
        timeInput.text! = ""
        dayofWeekInput.text! = ""
        
    }
    
    func insertItem(previousItems: [String], newItem: String) -> [String] {
        //if compareDates == 0, sort based on time
        var newItems = previousItems
        let newItemComponents = newItem.components(separatedBy: "`")
        var i = 0
        for item in previousItems {
            let components = item.components(separatedBy: "`")
            //if new date is before old date, insert before
            if compareDates(oldDate: components[3], newDate: newItemComponents[3]) == -1 {
                newItems.insert(newItem, at: i)
                return newItems
            }
            //if new date is same as old date, insert based on time
            else if compareDates(oldDate: components[1], newDate: newItemComponents[1]) == 0 {
                if components[3].integerValue! > newItemComponents[3].integerValue! {
                    newItems.insert(newItem, at: i)
                }
                else { newItems.insert(newItem, at: i + 1) }
                return newItems
            }
            i += 1
            
        }
        newItems.append(newItem)
        return newItems
    }
    
    func compareDates(oldDate: String, newDate: String) -> Int {
        //returns -1 for new date is earlier date, 0 for same date, 1 for later date
        let oldDateComponents = oldDate.components(separatedBy: "/")
        let newDateComponents = newDate.components(separatedBy: "/")
        if oldDateComponents[0].integerValue! < newDateComponents[0].integerValue! {
            return 1
        }
        else if newDateComponents[0].integerValue! < oldDateComponents[0].integerValue! {
            return -1
        }
        else {
            if oldDateComponents[1].integerValue! < newDateComponents[1].integerValue! {
                return 1
            }
            else if newDateComponents[1].integerValue! < oldDateComponents[1].integerValue! {
                return -1
            }
            else { return 0 }
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
