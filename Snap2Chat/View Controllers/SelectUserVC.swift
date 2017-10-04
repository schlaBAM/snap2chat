//
//  SelectUserVC.swift
//  Snap2Chat
//
//  Created by BAM on 2017-10-03.
//  Copyright © 2017 BAM. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SelectUserVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        Database.database().reference().child("users").observe(DataEventType.childAdded) { (snapshot) in
            
            let user = User()
            let value = snapshot.value as? NSDictionary
            user.email = value?["email"] as? String 
//            user.email = snapshot.value!(forKey: "email") as! String
            user.uuid = snapshot.key
            
            self.users.append(user)
            self.tableView.reloadData()
        }

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = users[indexPath.row].email
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
