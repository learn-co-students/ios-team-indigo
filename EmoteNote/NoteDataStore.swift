//
//  NoteDatastore.swift
//  EmoteNote
//
//  Created by William Leahy on 4/19/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import Foundation
import CoreData

final class NoteDataStore {
    static let sharedInstance = NoteDataStore()
    private init() {}
    
    var notes : [Note] = []
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "EmoteNote")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveNote(text: String){
        
        // pop up if empty
        // let contextDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context = persistentContainer.viewContext
        let note = Note(context: context)
        
        note.content = text
        EmotionAPI.getEmotionFor(bigText: text) { (result) in
            
            switch result {
            case let .sentiment(score):
                print(score)
                note.score = score
            case let .emotionScores(scores):
                print(scores)
                note.anger = scores.anger!
                note.sadness = scores.sadness!
                note.joy = scores.joy!
                note.fear = scores.fear!
                note.disgust = scores.disgust!
            }
        }
        
        note.date = Date() as NSDate
        if let date = note.date {
            print(date)
        }
        if let content = note.content {
            print(content)
        }
        self.saveContext()
        print("saving a note")
        
    }
    
    func getNotes() {
        print("getNote is being called")
        // let contextDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context = persistentContainer.viewContext
        
        do {
            self.notes = try context.fetch(Note.fetchRequest())
            print(self.notes)
        } catch {
            print("could not fetch any data")
        }
    }
    
    
}
