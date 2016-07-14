//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Daniel J Janiak on 7/14/16.
//  Copyright © 2016 Daniel J Janiak. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* Set up access to the data store */
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext: NSManagedObjectContext = appDelegate.managedObjectContext
        
        /* Insert a new user into the data store */
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: managedObjectContext)
        // Set values for the attributes
        newUser.setValue("Daniel", forKey: "username")
        newUser.setValue("dadada", forKey: "password")
        
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Unable to save data")
        }
        
        /* Retrieve info from the data store */
        let fetchRequest = NSFetchRequest(entityName: "Users")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try managedObjectContext.executeFetchRequest(fetchRequest)
            print(results)
            
            if results.count > 0 {
                for item in results as! [NSManagedObject] {
                    print(item.valueForKey("username")!)
                    print(item.valueForKey("password")!)
                }
            }
            
        } catch {
            fatalError("Failed to retrieve data from the data store ")
        }
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

