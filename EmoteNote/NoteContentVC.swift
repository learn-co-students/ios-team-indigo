//
//  NoteContentVC.swift
//  EmoteNote
//
//  Created by William Leahy on 4/21/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import UIKit

class NoteContentVC: UIViewController {
    
    let store = NoteDataStore.sharedInstance
    
    var selectedNote : Note!

    @IBOutlet weak var noteContentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColor()
        setNoteViewConstraints()
        setNoteData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNoteData() {
        if let currentNote = selectedNote {
            noteContentTextView.text = currentNote.content
        }
    }
    
    func setNoteViewConstraints() {
        noteContentTextView.isEditable = false
        noteContentTextView.layer.cornerRadius = 2.5
        noteContentTextView.isScrollEnabled = true
    }
    
    func setColor() {
        noteContentTextView.backgroundColor = ColorPallet.noteBackgroundColor
    }
    // keyword content

}
