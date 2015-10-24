//
//  ViewController.swift
//  ORCNote
//
//  Created by Yi Qin on 10/24/15.
//  Copyright © 2015 Yi Qin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recognizedTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Test ORC
        let operation = G8RecognitionOperation(language: "eng")
        operation.tesseract.image = UIImage(named: "IMG_0655.JPG")?.g8_blackAndWhite()
        
        operation.recognitionCompleteBlock = { (recognizedTesseract: G8Tesseract!) -> Void in
            print(recognizedTesseract.recognizedText)
            self.recognizedTextView.text = recognizedTesseract.recognizedText
            SVProgressHUD.dismiss()
        }
        
        let queue = NSOperationQueue()
        queue.addOperation(operation)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        SVProgressHUD.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

