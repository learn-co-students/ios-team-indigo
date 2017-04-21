//
//  NoteContentVC.swift
//  EmoteNote
//
//  Created by William Leahy on 4/21/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import UIKit
import Charts

class NoteContentVC: UIViewController {
    
    let store = NoteDataStore.sharedInstance
    
    
    
    var selectedNote : Note!
    
//    var angerIndex : Double = 0.0
//    var sadnessIndex : Double = 0.0
//    var joyIndex : Double = 0
//    var fearIndex : Double = 0
//    var digustInded : Double = 0
    var emotionIndex = ["anger", "sadness", "joy", "fear", "digust"]
    var emotionIndexValue : [Double] = []

    
    
    @IBOutlet weak var noteContentTextView: UITextView!
    @IBOutlet weak var barChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emotionIndexValue = setEmotionIndexes()
        print(emotionIndexValue)
        setChartItem()
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
    
    // MARK : Need keyword content
    
    func setChartItem() {
        barChartView.noDataText = "There is no data currently available for the current day"
        barChartView.noDataTextColor = UIColor.red
    }

    func setEmotionIndexes() -> [Double] {
        let angerIndex = selectedNote.anger
        let sadnessIndex = selectedNote.sadness
        let joyIndex = selectedNote.joy
        let fearIndex = selectedNote.fear
        let disgustIndex = selectedNote.disgust
        
        return [angerIndex, sadnessIndex, joyIndex, fearIndex, disgustIndex]
    }
}
