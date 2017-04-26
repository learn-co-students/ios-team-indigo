//
//  NoteTableVCell.swift
//  EmoteNote
//
//  Created by William Leahy on 4/20/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import Foundation
import UIKit

class NoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var customCircle: UIView!
    
    func setFont() {
        self.contentView.backgroundColor = ColorPallet.cellBackgroundColor
    }

    func setColorCircle(score : Double) -> UIColor {
        if score >= 0 {
            return UIColor(red: 190/225, green: 237/225, blue: (166/225), alpha: 1) // 171, 214, 175
        } else {
            return UIColor(red: 226/225, green: 131/225, blue: (131/224), alpha: 1) // 226, 131, 131
        }
    }
    
    func setCircle(note: Note){
        customCircle.backgroundColor = setColorCircle(score: note.score)
        customCircle.layer.cornerRadius = customCircle.frame.size.width/2
    }
    
}
