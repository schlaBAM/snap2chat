//
//  SnapsVC.swift
//  Snap2Chat
//
//  Created by BAM on 2017-10-01.
//  Copyright © 2017 BAM. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SnapsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let imagePicker = UIImagePickerController()
    var snaps = [Snap]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("snaps").observe(DataEventType.childAdded) { (snapshot) in
        
            let snap = Snap()
            let value = snapshot.value as? NSDictionary
            snap.imageURL = value?["imageURL"] as? String
            snap.fromUser = value?["fromUser"] as? String
            snap.description = value?["description"] as? String

            self.snaps.append(snap)
            self.tableView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
}
