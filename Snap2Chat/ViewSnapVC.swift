//
//  ViewSnapVC.swift
//  Snap2Chat
//
//  Created by BAM on 2017-10-03.
//  Copyright © 2017 BAM. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewSnapVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionText: UILabel!
    var snap : Snap!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: snap.imageURL)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data!)
            }
        }
        
        descriptionText.text = snap.description
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("snaps").child(snap.uuid).removeValue()
        
    }
}

