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
    
    @IBOutlet weak var noteView: UITextView!
    
    @IBAction func dismissButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        print("dismissed note view")
    }
    
    @IBAction func saveNoteButton(_ sender: UIButton) {
        store.saveNote(text: noteView.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        setNoteConstraints()
        
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
            self.noteView.text = "please type how you are feeling here."
            self.noteView.textColor = UIColor.gray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("text view was clicked")
        self.noteView.text = ""
        self.noteView.textColor = UIColor.black
    }
    
    func setBackgroundColor() {
        self.view.backgroundColor = UIColor(red: 147/225, green: 234/225, blue: 225/225, alpha: 1)
    }
    
    
    
}
