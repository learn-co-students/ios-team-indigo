//
//  NLIfile.swift
//  EmoteNote
//
//  Created by William Leahy on 4/17/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import Foundation
import NaturalLanguageUnderstandingV1


func emotionTest() {
    
    let username = userID
    let password = passwordID
    let version = versionDate
    
    let naturalLanguageUnderstanding = NaturalLanguageUnderstanding(username: username, password: password, version: version)
    
    
    let textToAnalyze = "Today i hung out with my boyfriend and it made me really happy. But then i saw a bird get hit by a car and i started to cry"
    
    // let features = Features(concepts: ConceptsOptions(), emotion: EmotionOptions(), entities: EntitiesOptions())
    
    let features = Features(emotion: EmotionOptions())
    
    let parameters = Parameters(features: features, text: textToAnalyze)
    let failure = { (error: Error) in print(error) }
    
    naturalLanguageUnderstanding.analyzeContent(withParameters: parameters, failure: failure, success: { (results: AnalysisResults) in
        
        if let res = results.emotion {
            if let doc = res.document {
                if let docEmotion = doc.emotion {
                    // let emotions = Emotions(res: docEmotion)
                    // you can grab each individual emotion
                    print("this note has an anger score of \(docEmotion.anger!)")
                    print("this note has an disgust score of \(docEmotion.disgust!)")
                    print("this note has an joy score of \(docEmotion.joy!)")
                    print("this note has an sadness score of \(docEmotion.sadness!)")
                    print("this note has an fear score of \(docEmotion.fear!)")
                }
            }
        }
    })
}



func keywordsTest() {
    let username = userID
    let password = passwordID
    let version = versionDate
    
    let naturalLanguageUnderstanding = NaturalLanguageUnderstanding(username: username, password: password, version: version)
    let textToAnalyze = "Today i hung out with my boyfriend and it made me really happy. But then i saw a bird get hit by a car and i started to cry"
    let features = Features(keywords: KeywordsOptions())
    let parameters = Parameters(features: features, text: textToAnalyze)
    let failure = { (error: Error) in print(error) }
    
    naturalLanguageUnderstanding.analyzeContent(withParameters: parameters, failure: failure) { (results : AnalysisResults) in
        
        if let theseResults = results.keywords {
            for results in theseResults {
                if let text = results.text {
                    print("\(text), \(results.relevance!)")
                }
            }
        }  
    }
}


func sentimentTest() {
    let username = userID
    let password = passwordID
    let version = versionDate
    
    let naturalLanguageUnderstanding = NaturalLanguageUnderstanding(username: username, password: password, version: version)
    let textToAnalyze = "Today i hung out with my boyfriend and it made me really happy. But then i saw a bird get hit by a car and i started to cry"
    let features = Features(sentiment: SentimentOptions())
    let parameters = Parameters(features: features, text: textToAnalyze)
    let failure = { (error: Error) in print(error) }
    
    naturalLanguageUnderstanding.analyzeContent(withParameters: parameters, failure: failure) { (results : AnalysisResults) in
        if let theseResults = results.sentiment {
            if let document = theseResults.document {
                if let score = document.score {
                    print(score)
                    if score > 0.05 {
                        print("the document in positive")
                    } else {
                        print("the document is negative")
                    }
                }
            }
        }
    
    }
    
    
}


//struct Emotions {
//    var anger: Double
//    
//    
//    init(res: EmotionScores) {
//        if let anger = res.anger {
//            self.anger = anger
//        }
//    }
//}



