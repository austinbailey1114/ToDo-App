//
//  NavigationViewController.swift
//  ToDoApp
//
//  Created by Austin Bailey on 8/30/17.
//  Copyright © 2017 Austin Bailey. All rights reserved.
//

import UIKit
import CoreData

extension String {
    var doubleValue: Double? {
        return Double(self)
    }
    var floatValue: Float? {
        return Float(self)
    }
    var integerValue: Int? {
        return Int(self)
    }
}

class NavigationViewController: UINavigationController {
    
    static var keepContext: NSManagedObjectContext?
    static var items: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
