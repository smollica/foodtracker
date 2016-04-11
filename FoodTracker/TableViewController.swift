//
//  TableViewController.swift
//  FoodTracker
//
//  Created by Monica Mollica on 2016-04-11.
//  Copyright © 2016 Sergio Mollica. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    var meals = [Meal]()

    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
        if let savedMeals = loadMeals() {
            meals += savedMeals
        } else {
        }
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mealCell") as! MealTableViewCell
        
        let meal = meals[indexPath.row]
        
        cell.mealImageView.image = meal.image
        cell.mealNameLabel.text = meal.name
        cell.mealRatingView.rating = meal.rating

        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            meals.removeAtIndex(indexPath.row)
            saveMeals()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
        }
    }
    
    // MARK: Actions
    
    @IBAction func unwindToVC(segue: UIStoryboardSegue) {
        if let vc = segue.sourceViewController as? ViewController {
            let meal = vc.meal
            meals.append(meal!)
            saveMeals()
            tableView.reloadData()
        }
    }
    
    // MARK: Data Persistence
    
    func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    
    func loadMeals() -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as? [Meal]
    }
}
