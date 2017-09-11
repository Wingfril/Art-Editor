//
//  ViewController.swift
//  Enhance Your Art
//
//  Created by Ziyan Mo on 3/8/17.
//  Copyright © 2017 Ziyan Mo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    var curImage:UIImage!
    var flag = false
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        //print(curImage)
        curImage = selectedImage
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        flag = true
        print("Finished picking image")
        print(curImage)
        MovingToLineartView()
        
    }
    
    // ERROR: Right now, as soon as "edit line art" is pressed,
    // Prepareforsegue is called; however, curimage is
    // NULL right now, since no image is selected.
    // We need to find a way to have call imagePicker controller
    // before calling prepareforsegue.
    @IBAction func toLineart(_ sender: UIButton)
    {
        print("Inside tolineart")
        // Hide the keyboard.
        //nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        print("back to lineart actino funct")
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func MovingToLineartView()
    {
        
        self.performSegue(withIdentifier: "Lineart", sender: self)
    }
    
    
    @IBAction func toLandscapeGeneration(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "LandscapeGeneration", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("Inside prepare")
        if(segue.identifier == "Lineart")
        {
            let LineartViewController = segue.destination as! LineartViewController
            LineartViewController.curImage = curImage
        }
        
        
    }
}
