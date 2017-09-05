//
//  NewItemViewController.swift
//  ToDoApp
//
//  Created by Austin Bailey on 8/30/17.
//  Copyright © 2017 Austin Bailey. All rights reserved.
//

import UIKit
import CoreData

class NewItemViewController: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var itemInput: UITextField!
    @IBOutlet weak var timeInput: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var testView: UIView!
    
    var keepContext: NSManagedObjectContext?
    var items: NSManagedObject?
    
    override func viewDidLoad() {
        
        keepContext = NavigationViewController.keepContext
        items = NavigationViewController.items
        super.viewDidLoad()
        let datePicker = UIDatePicker()
        datePicker.minuteInterval = 15
        datePicker.timeZone = NSTimeZone.local
        timeInput.inputView = datePicker
        
        datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(_:)), for: .valueChanged)
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "EEEE MM/dd hh:mm a"
        
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: datePicker.date)
        timeInput.text! = selectedDate
        
        timeInput.addBorder(side: .bottom, thickness: 1.0, color: UIColor.lightGray)
        
        
        
        
        itemInput.becomeFirstResponder()
        

        // Do any additional setup after loading the view.
    }

    @IBAction func saveButton(_ sender: UIButton) {
        //add to CoreData
        let dateComponents = timeInput.text!.components(separatedBy: " ")
        let newItem = itemInput.text! + "`" + toMilitary(time: dateComponents[2] + ":" + dateComponents[3]) + "`" + dateComponents[0] + "`" + dateComponents[1]
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
        
        
        for item in UpdatedItems {
            print(item)
        }
        
    }
    
    
    func insertItem(previousItems: [String], newItem: String) -> [String] {
        //if compareDates == 0, sort based on time
        print(previousItems.count)
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
            else if compareDates(oldDate: components[3], newDate: newItemComponents[3]) == 0 {
                //PROBLEM if you have more than 1 item on this date, itll just add at i+1
                if compareTimes(oldTime: components[1], newTime: newItemComponents[1]) == -1 {
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
    
    func compareTimes(oldTime: String, newTime: String) -> Int {
        //returns -1 for time is earlier, 0 for same, 1 for later
        let oldTimeComponents = oldTime.components(separatedBy: ":")
        let newTimeComponents = newTime.components(separatedBy: ":")
        if oldTimeComponents[0].integerValue! < newTimeComponents[0].integerValue! {
            return 1
        }
        else if newTimeComponents[0].integerValue! < oldTimeComponents[0].integerValue! {
            return -1
        }
        else {
            if oldTimeComponents[1].integerValue! < newTimeComponents[1].integerValue! {
                return 1
            }
            else if newTimeComponents[1].integerValue! < oldTimeComponents[1].integerValue! {
                return -1
            }
            else {return 0}
        }
    }
    
    func toMilitary(time: String) -> String {
        let timeComponents = time.components(separatedBy: ":")
        var hour = timeComponents[0]
        let half = timeComponents[2]
        if half == "AM" {
            if hour == "12" {
                hour = "00"
            }
        }
        else if half == "PM" {
            if hour != "12" {
                var intHour = hour.integerValue!
                intHour += 12
                hour = String(intHour)
            }
        }
        return hour + ":" + timeComponents[1]
    }
    
    func datePickerValueChanged(_ sender: UIDatePicker){
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "EEEE MM/dd hh:mm a"
        
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: sender.date)
        timeInput.text! = selectedDate
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        itemInput.resignFirstResponder()
        timeInput.resignFirstResponder()
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
