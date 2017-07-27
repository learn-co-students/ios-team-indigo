//
//  NoteViewController.swift
//  EmoteNote
//
//  Created by William Leahy on 4/18/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

// clear - remove comments before shipping

class NoteVC: UIViewController, UITextViewDelegate, CLLocationManagerDelegate {
    
    let store = NoteDataStore.sharedInstance
    let locationManager = CLLocationManager()
    
    var gradientLayer: CAGradientLayer!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveNoteButton: UIButton!
    @IBOutlet weak var noteView: UITextView!
    @IBAction func cancelButton(_ sender: UIButton) {
        self.dismissNoteVC()
    }
    
    @IBAction func saveNoteButton(_ sender: UIButton) {
        if noteView.text.isEmpty || noteView.text == "please type how you are feeling... (Min. 15 characters)" {
            emptyAlert()
        } else {
            self.saveNoteButton.isEnabled = false
            store.saveNote(text: noteView.text,
                           latitude: (locationManager.location?.coordinate.latitude)!,
                           longitude: (locationManager.location?.coordinate.longitude)!,
                           completion: {
                            self.dismissNoteVC()
            })
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        setNoteConstraints()
        styleSaveButton()
        styleCancelButtonI()
        setLocationsServices()
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setNoteConstraints() {
        self.noteView.isEditable = true
        self.noteView.isSelectable = true
        self.noteView.layer.cornerRadius = 5
        
        let content = self.noteView.text
        if (content?.isEmpty)! {
            self.noteView.text = "please type how you are feeling... (Min. 15 characters)"
            self.noteView.textColor = UIColor.gray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("text view was clicked")
        // only clears text once; at the beginning of edits
        if self.noteView.text == "please type how you are feeling... (Min. 15 characters)" {
            self.noteView.text = ""
            self.noteView.textColor = UIColor.black
        }
        
        // TODO : correct text alignment spacing bug
    }
    
    func setBackgroundColor() {
        self.view.backgroundColor = ColorPallet.noteBackgroundColor
    }
    
    func dismissNoteVC() {
        self.dismiss(animated: true, completion: nil)
        print("dismissed note view")
    }
    
    func createGradientLayer() {
        
        print("Creating sublayer")
        
        let colorOne = UIColor(hex: "83a4d4").cgColor
            print(colorOne)
        let colorTwo = UIColor(hex: "b6fbff").cgColor
            print(colorTwo)
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        gradientLayer.colors = [colorOne, colorTwo]
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    
    }
    
    func styleSaveButton() {
        self.saveNoteButton.backgroundColor = ColorPallet.saveButtonColor
        self.saveNoteButton.layer.cornerRadius = 2.5
        self.saveNoteButton.widthAnchor.constraint(equalTo: noteView.widthAnchor).isActive = true
        self.saveNoteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func styleCancelButtonI() {
        self.cancelButton.backgroundColor = ColorPallet.saveButtonColor
        self.cancelButton.layer.cornerRadius = 2.5
        self.cancelButton.widthAnchor.constraint(equalTo: noteView.widthAnchor).isActive = true
        self.cancelButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func emptyAlert() {
        let alert = UIAlertController(title: "Your note is empty", message: "Please add content to your note before saving", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        return
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let _:CLLocation = locations[0]
        locationManager.stopUpdatingLocation()
    }
    
    func setLocationsServices() {
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        // Ask for Authorization from the User.
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //This will hide the keyboard
    }
    
    
    
    
}
