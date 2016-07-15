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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* Set up access to the data store */
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext: NSManagedObjectContext = appDelegate.managedObjectContext
        
        /* Insert a new user into the data store */
        //let newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: managedObjectContext)
        // Set values for the attributes
        /*
         newUser.setValue("Daniel", forKey: "username")
         newUser.setValue("dadada", forKey: "password")
         */
        
        // Quickly add a new user
        // createNewUser("Sabriel", userPassword: "1234")
        
        // Quickly remove a new user
        
        
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Unable to save data")
        }
        
        /* Retrieve info from the data store */
        let fetchRequest = NSFetchRequest(entityName: "Users")
        fetchRequest.returnsObjectsAsFaults = false
        
        /* Refine search */
        //fetchRequest.predicate = NSPredicate(format: "username = %@", "Daniel")
        
        do {
            let results = try managedObjectContext.executeFetchRequest(fetchRequest)
            print(results)
            
            if results.count > 0 {
                for item in results as! [NSManagedObject] {
                    
                    print(item.valueForKey("username")!)
                    print(item.valueForKey("password")!)
                    
                    /* Convert from NSManagedObject to string */
                    if let username = item.valueForKey("username") as? String {
                        print("Here is the username as a String type: ")
                        print(username)
                    }
                    
                    /* Change/update the username */
                    item.setValue("Danimal", forKey: "username")
                    
                    // Test
                    if let updatedUsername = item.valueForKey("username") as? String {
                        print("Here is the username as a String type after updating : ")
                        print(updatedUsername)
                    }
                    
                    do {
                        try managedObjectContext.save()
                    } catch {
                        fatalError("Unable to save data")
                    }
                    
                }
            }
            
        } catch {
            fatalError("Failed to retrieve data from the data store ")
        }
        
        deleteUser("Danimal")
        
        
        
        
        
    }
    
    // MARK: - Helpers
    func deleteUser(userName: String) {
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext: NSManagedObjectContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Users")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "username = %@", userName)
        
        do {
            let results = try managedObjectContext.executeFetchRequest(fetchRequest)
            
            if results.count > 0 {
                for item in results as! [NSManagedObject] {
                    
                    managedObjectContext.deleteObject(item)
                    do {
                        try managedObjectContext.save()
                    } catch {
                        fatalError("Unable to save data")
                    }
                }
            }
            
        } catch {
            fatalError("Failed to retrieve data from the data store ")
        }
        
    }
    
    func createNewUser(userName: String, userPassword: String) {
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext: NSManagedObjectContext = appDelegate.managedObjectContext
        
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: managedObjectContext)
         // Set values for the attributes
         newUser.setValue(userName, forKey: "username")
         newUser.setValue(userPassword, forKey: "password")
    }
    
    
    
    
}

