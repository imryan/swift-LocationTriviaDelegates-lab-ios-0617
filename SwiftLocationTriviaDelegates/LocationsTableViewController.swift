//
//  LocationsTableViewController.swift
//  SwiftLocationTriviaDelegates
//
//  Created by Ryan Cohen on 7/25/16.
//  Copyright © 2016 Ryan Cohen. All rights reserved.
//

import UIKit

class LocationsTableViewController: UITableViewController, AddLocationViewControllerDelegate {
    
    var locations: [Location] = []
    
    // MARK: - Table

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Locations"
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellId", forIndexPath: indexPath)

        let location = locations[indexPath.row]
        cell.textLabel?.text = location.name
        
        if let count: Int = location.trivia.count {
            cell.detailTextLabel?.text = "\(count) trivia"
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - View
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let addLocationViewController = segue.destinationViewController as! AddLocationViewController
        addLocationViewController.delegate = self
    }
}

extension LocationsTableViewController {
    
    func addLocationViewControllerDidCancel(controller: AddLocationViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addLocationViewController(controller: AddLocationViewController, shouldAllowLocationNamed name: String) -> Bool {
        var shouldAllow = true
        
        for location in locations {
            if location.name == name {
                shouldAllow = false
            }
        }
        
        return shouldAllow
    }
    
    func addLocationViewController(controller: AddLocationViewController, didAddLocationNamed name: String) {
        let location = Location(name: name, trivia: [])
        locations.append(location)
        
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
}
