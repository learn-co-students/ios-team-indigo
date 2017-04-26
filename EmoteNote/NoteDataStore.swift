//
//  NoteDatastore.swift
//  EmoteNote
//
//  Created by William Leahy on 4/19/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import MapKit
import CoreLocation

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
    
    func saveNote(text: String, latitude: Double, longitude: Double, completion: @escaping () -> ()){
        
        let context = persistentContainer.viewContext
        let note = Note(context: context)
        
        EmotionAPI.getEmotionFor(bigText: text) { (result) in
            
            switch result {
            case let .sentiment(score):
                print(score)
                note.score = score
            case let .emotionScores(scores):
                print(scores)
                note.anger = DoubleConverter.willConvertDouble(as: scores.anger!)
                note.sadness = DoubleConverter.willConvertDouble(as: scores.sadness!)
                note.joy = DoubleConverter.willConvertDouble(as: scores.joy!)
                note.fear = DoubleConverter.willConvertDouble(as: scores.fear!)
                note.disgust = DoubleConverter.willConvertDouble(as: scores.disgust!)
            }
            
            note.content = text
            note.date = Date() as NSDate
            note.latitude = latitude
            note.longitude = longitude
            
            self.saveContext()
            print("saving a note")
            completion()
        }
    }
    
    func getNotes() {
        print("getNote is being called")
        let context = persistentContainer.viewContext
        
        do {
            self.notes = try context.fetch(Note.fetchRequest())
            print(self.notes)
        } catch {
            print("could not fetch any data")
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    
    func deleteAllRecords() {
        let context = persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
}
