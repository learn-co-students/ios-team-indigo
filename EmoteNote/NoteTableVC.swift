//
//  noteTableVC.swift
//  EmoteNote
//
//  Created by William Leahy on 4/19/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import UIKit

class NoteTableVC: UITableViewController {
    
    let store = NoteDataStore.sharedInstance
    
    var reuseIdentifier : String = "noteIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // get data from core data
        print("view will appearing")
        store.getNotes()
        // reload tableview
        tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return store.notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let note = store.notes[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if let strDate = note.date {
            let result = dateFormatter.string(from: strDate as Date)
            cell.textLabel?.text = String(describing: result)
        }
        
        return cell
    }

}
