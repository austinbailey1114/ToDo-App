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
    
    var keepContext: NSManagedObjectContext?
    var items: NSManagedObject?
    
    override func viewDidLoad() {
        keepContext = NavigationViewController.keepContext
        items = NavigationViewController.items
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func saveButton(_ sender: UIButton) {
        let newItem = itemInput.text! + "`" + timeInput.text! + "`" + dayofWeekInput.text!
        let previousItems = items!.value(forKey: "toDo") as! [String]
        let UpdatedItems = [newItem] + previousItems
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
