//
//  NoteViewController.swift
//  EmoteNote
//
//  Created by William Leahy on 4/18/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import UIKit

class NoteVC: UIViewController, UITextViewDelegate {
    
    let store = NoteDataStore.sharedInstance
    
    @IBOutlet weak var saveNoteButton: UIButton!
    @IBOutlet weak var noteView: UITextView!
    
    
    @IBAction func saveNoteButton(_ sender: UIButton) {
        if noteView.text.isEmpty || noteView.text == "please type how you are feeling..." {
            emptyAlert()
        } else {
            store.saveNote(text: noteView.text) { (view) in
                self.dismissNoteVC()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        setNoteConstraints()
        styleSaveButton()
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
            self.noteView.text = "please type how you are feeling..."
            self.noteView.textColor = UIColor.gray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("text view was clicked")
        self.noteView.text = ""
        self.noteView.textColor = UIColor.black
    }
    
    func setBackgroundColor() {
        self.view.backgroundColor = ColorPallet.noteBackgroundColor
    }
    
    func dismissNoteVC() {
        self.dismiss(animated: true, completion: nil)
        print("dismissed note view")
    }
    
    func styleSaveButton() {
        self.saveNoteButton.backgroundColor = ColorPallet.saveButtonColor
        self.saveNoteButton.layer.cornerRadius = 2.5
        self.saveNoteButton.widthAnchor.constraint(equalTo: noteView.widthAnchor, multiplier: 0.95).isActive = true
        self.saveNoteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func emptyAlert() {
        let alert = UIAlertController(title: "Your note is empty", message: "Please add content to your note before saving", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        return
    }
    
}
