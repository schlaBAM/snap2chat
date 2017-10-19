//
//  CreateVC.swift
//  Snap2Chat
//
//  Created by BAM on 2017-10-01.
//  Copyright © 2017 BAM. All rights reserved.
//

import UIKit
import FirebaseStorage

class CreateVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    var imageUUID = UUID.init().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        createButton.isEnabled = false
        textField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createTapped(_ sender: Any) {
        createButton.isEnabled = false
        createButton.setTitle("Uploading...", for: .normal)
        let images = Storage.storage().reference().child("images")
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)
        images.child("\(imageUUID).jpg").putData(imageData!, metadata: nil) { (metadata, error) in
            if error != nil {
                print("Firebase storage upload error: \(error)")
                self.createButton.isEnabled = true
                self.createButton.setTitle("Try Again", for: .normal)
            } else {
                print("Image upload successful")
                let snap = Snap()
                snap.description = self.textField.text
                snap.imageURL = metadata?.downloadURL()?.absoluteString
                snap.imageUUID = self.imageUUID
                
                self.performSegue(withIdentifier: "selectUserSegue", sender: snap)
            }
        }
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
//        imagePicker.sourceType = .camera
        //for testing, making it photo album
        imagePicker.sourceType = .savedPhotosAlbum

        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        imageView.backgroundColor = .clear
        createButton.isEnabled = true
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! SelectUserVC
        nextVC.snap = sender as! Snap
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
