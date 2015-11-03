//
//  ViewController.swift
//  ORCNote
//
//  Created by Yi Qin on 10/24/15.
//  Copyright © 2015 Yi Qin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let queue = NSOperationQueue()
    
    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var recognizedTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Test ORC
        /*
        let operation = G8RecognitionOperation(language: "eng")
        operation.tesseract.image = UIImage(named: "IMG_0655.JPG")?.g8_blackAndWhite()
        
        operation.recognitionCompleteBlock = { (recognizedTesseract: G8Tesseract!) -> Void in
            print(recognizedTesseract.recognizedText)
            self.recognizedTextView.text = recognizedTesseract.recognizedText
            SVProgressHUD.dismiss()
        }
        
        queue.addOperation(operation)
        */
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    func processImage(image:UIImage) {
        
        let operation = G8RecognitionOperation(language: "eng")
        operation.tesseract.image = image
        // operation.tesseract.charBlacklist = "\"'?~/\\.,<>!#$%^&*()[]{}|"
        
        let punctuation = "@-"
        let number = "1234567890"
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        
        operation.tesseract.charWhitelist = punctuation+number+alphabet+alphabet.lowercaseString
        
        
        operation.recognitionCompleteBlock = { (recognizedTesseract: G8Tesseract!) -> Void in
            print(recognizedTesseract.recognizedText)
            self.recognizedTextView.text = recognizedTesseract.recognizedText
            SVProgressHUD.dismiss()
        }
        
        SVProgressHUD.show()
        queue.addOperation(operation)
    }
    
    
    @IBAction func takePhotoAction(sender: AnyObject) {
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(imagePicker, animated: true, completion: { () -> Void in
            
        })
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        let fixedOrientationImage = image.fixOrientation()
        processImage(fixedOrientationImage)
        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
        
    }


}

