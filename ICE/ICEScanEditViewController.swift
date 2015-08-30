//
//  ICEScanEditViewController.swift
//  ICE
//
//  Created by Andrea Cabral on 30.11.14.
//  Copyright (c) 2014 Andrea Cabral. All rights reserved.
//

import UIKit

class ICEScanEditViewController: UIViewController {

    @IBOutlet weak var retakeButton: UIBarButtonItem!
    @IBOutlet weak var cropButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var captionTextField: UITextField!
    
//    var currentImages: [UIImage] = []
//    var currentImage: UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func retakeImage(sender: UIBarButtonItem) {
        println("retake picture")
    }
    
    @IBAction func cropImage(sender: UIBarButtonItem) {
        println("crop picture")

    }

    @IBAction func saveImage(sender: UIBarButtonItem) {
        println("save picture")

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
