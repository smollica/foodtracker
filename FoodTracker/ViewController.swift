//
//  ViewController.swift
//  FoodTracker
//
//  Created by Monica Mollica on 2016-04-11.
//  Copyright © 2016 Sergio Mollica. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Outlets

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ratingSystem: RatingSystem!
    
    // MARK: Properties
    
    let imagePickerController = UIImagePickerController()
    var meal: Meal?

    // MARK: Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        imagePickerController.sourceType = .PhotoLibrary
        //imagePickerController.sourceType = .Camera
        imagePickerController.delegate = self

    }
    
    // MARK: UITextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = selectedImage
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Actions
    
    @IBAction func SubmitButtonPressed(sender: AnyObject) {
        labelName.text = textField.text
    }

    @IBAction func imageViewTapped(sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func createMealButtonPressed(sender: AnyObject) {
        meal = Meal(name: textField.text!, image: imageView.image, rating: ratingSystem.rating)!
        performSegueWithIdentifier("unwind", sender: self)
    }

}