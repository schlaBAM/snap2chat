//
//  SnapsVC.swift
//  Snap2Chat
//
//  Created by BAM on 2017-10-01.
//  Copyright © 2017 BAM. All rights reserved.
//

import UIKit

class SnapsVC: UIViewController {

    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
