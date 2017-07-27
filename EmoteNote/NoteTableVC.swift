//
//  noteTableVC.swift
//  EmoteNote
//
//  Created by William Leahy on 4/19/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import UIKit

// clear - remove comments before ship

class NoteTableVC: UITableViewController {
    
    let store = NoteDataStore.sharedInstance
    
    var gradientLayer : CAGradientLayer!
    
    var reuseIdentifier : String = "noteIdentifier"
    let segueIdentifier : String = "noteShowSegue"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        createGradientLayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        store.getNotes()
        tableView.reloadData()
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NoteTableViewCell
        let note = store.notes[indexPath.row]
        
        // sets the color of the cells
        cell.backgroundColor = UIColor(white: 1, alpha: 0.125) // currently slightly opaque
        
        // sets the cell separator line with the tableview
        tableView.separatorColor = UIColor.gray
        
        //
        
        // creates content for the tableview cell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy" // "dd MM yyyy"
        if let strDate = note.date {
            let result = dateFormatter.string(from: strDate as Date)
            cell.dateLabel?.text = String(describing: result)
            cell.contentLabel?.text = note.content!
            // cell.setFont()
            cell.setCircle(note: note)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("cell has been tapped")
        if segue.identifier != segueIdentifier { return }
        if let dest = segue.destination as? NoteContentVC,
            let indexPath = tableView.indexPathForSelectedRow {
            dest.selectedNote = store.notes[indexPath.row]
        }
    }
    
}
