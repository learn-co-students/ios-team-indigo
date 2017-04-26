//
//  SettingsVC.swift
//  EmoteNote
//
//  Created by William Leahy on 4/26/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import UIKit
import CoreData

class SettingsVC: UIViewController {
    
    let store = NoteDataStore.sharedInstance

    @IBAction func clearButton(_ sender: Any) {
        didClickDelete()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func didClickDelete(){
        let refreshAlert = UIAlertController(title: "Refresh", message: "All data will be lost.", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.store.deleteAllRecords()
            print("i am deleting data")
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            refreshAlert.dismiss(animated: true, completion: nil)
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    


}