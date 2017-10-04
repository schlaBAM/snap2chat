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
            snap.imageUUID = value?["imageUUID"] as? String
            snap.uuid = snapshot.key

            self.snaps.append(snap)
            self.tableView.reloadData()
        }
    Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("snaps").observe(DataEventType.childRemoved) { (snapshot) in
            for (index, snap) in self.snaps.enumerated() {
                if snap.uuid == snapshot.key {
                    self.snaps.remove(at: index)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if snaps.count == 0{
            cell.textLabel?.text = "You have no snaps 😫"
            cell.textLabel?.textAlignment = .center
        } else {
            cell.textLabel?.text = snaps[indexPath.row].fromUser
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if snaps.count == 0{
            return 1
        } else {
            return snaps.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "viewSnapSegue", sender: snap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSnapSegue"{
            let nextVC = segue.destination as! ViewSnapVC
            nextVC.snap = sender as! Snap
        }
    }
}
