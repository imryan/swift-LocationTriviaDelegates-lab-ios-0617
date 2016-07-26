//
//  AddLocationViewController.swift
//  SwiftLocationTriviaDelegates
//
//  Created by Ryan Cohen on 7/25/16.
//  Copyright © 2016 Ryan Cohen. All rights reserved.
//

import UIKit

@objc protocol AddLocationViewControllerDelegate: class {
    func addLocationViewControllerDidCancel(controller: AddLocationViewController)
    func addLocationViewController(controller: AddLocationViewController, shouldAllowLocationNamed name: String) -> Bool
    func addLocationViewController(controller: AddLocationViewController, didAddLocationNamed name: String)
}

class AddLocationViewController: UIViewController, UITextFieldDelegate {
    
    weak var delegate: AddLocationViewControllerDelegate?
    
    @IBOutlet weak var locationNameField: UITextField!
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    
    // MARK: - Functions
    
    @IBAction func add() {
        view.endEditing(true)
        
        if let locationName = locationNameField.text {
            delegate?.addLocationViewController(self, didAddLocationNamed: locationName)
        }
    }
    
    @IBAction func cancel() {
        delegate?.addLocationViewControllerDidCancel(self)
    }
    
    // MARK: - Fields
    
    func validateLocationField() -> Bool {
        if let string = locationNameField.text {
            if string != "" {
                if let hasDelegate = delegate {
                    if hasDelegate.addLocationViewController(self, shouldAllowLocationNamed: string) {
                        addBarButtonItem.enabled = true
                    } else {
                        addBarButtonItem.enabled = false
                    }
                }
            } else {
                addBarButtonItem.enabled = false
            }
        }
        
        return false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if addBarButtonItem.enabled {
            add()
        }
        
        return false
    }
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationNameField.delegate = self
        locationNameField.becomeFirstResponder()
        locationNameField.addTarget(self, action: #selector(validateLocationField), forControlEvents: .EditingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

