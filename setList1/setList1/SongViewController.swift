//
//  SongViewController.swift
//  setList1
//
//  Created by Nicolaas Vallee on 2016-05-16.
//  Copyright © 2016 Nicolaas Vallee. All rights reserved.
//

import UIKit



class SongViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var ratingControl: RatingControl!
    
    
    /*
     This value is either passed by `SongTableViewController` in `prepareForSegue(_:sender:)`
     or constructed as part of adding a new song.
     */
    var song: Song?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Handle the text field’s user input through delegate callbacks.
        
        nameTextField.delegate = self
        
        // Set up views if editing an existing Song.
        if let song = song {
            navigationItem.title = song.name
            nameTextField.text = song.name
            noteTextField.text = song.note
            ratingControl.rating = song.rating
        }
        
        // Enable the Save button only if the text field has a valid Meal name.
        checkValidSongName()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // Hide the keyboard.
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidSongName()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func checkValidSongName() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    
    // MARK: Navigation

    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddSongMode = presentingViewController is UINavigationController
        
        if isPresentingInAddSongMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = nameTextField.text ?? ""
            let note = noteTextField.text
            
             let rating = ratingControl.rating
            
            // Set the song to be passed to SongTableViewController after the unwind segue.
            song = Song(name: name, note: note, rating: rating)
        }
    }
   
}

