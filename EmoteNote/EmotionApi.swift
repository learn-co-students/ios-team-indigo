//
//  NLIfile.swift
//  EmoteNote
//
//  Created by William Leahy on 4/17/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import Foundation
import NaturalLanguageUnderstandingV1

enum Result {
    case sentiment(Double)
    case emotionScores(EmotionScores)
    
}

class EmotionAPI {
    
    class func getEmotionFor(bigText: String, completion: @escaping (Result) -> Void ) {
        emotionTest(textToAnalyze: bigText, completion: completion)
        sentimentTest(textToAnalyze: bigText, completion: completion)
    }
    
    class func emotionTest(textToAnalyze: String, completion: @escaping (Result) -> ()) {
        let username = Constants.userID
        let password = Constants.passwordID
        let version = Constants.versionDate
        
        let naturalLanguageUnderstanding = NaturalLanguageUnderstanding(username: username, password: password, version: version)
    
        let features = Features(emotion: EmotionOptions())
        let parameters = Parameters(features: features, text: textToAnalyze)
        let failure = { (error: Error) in print(error) }
        
        naturalLanguageUnderstanding.analyzeContent(withParameters: parameters, failure: failure, success: { (results: AnalysisResults) in
            
            if let res = results.emotion {
                if let doc = res.document {
                    if let docEmotion = doc.emotion {
                        completion(.emotionScores(docEmotion))
                        // let emotions = Emotions(res: docEmotion)
                        // you can grab each individual emotion
            
                    }
                }
            }
        })
    }
    
    
    
    class func keywordsTest(textToAnalyze: String, completion: @escaping (String) -> ()) {
        let username = Constants.userID
        let password = Constants.passwordID
        let version = Constants.versionDate
        
        let naturalLanguageUnderstanding = NaturalLanguageUnderstanding(username: username, password: password, version: version)
        let features = Features(keywords: KeywordsOptions())
        let parameters = Parameters(features: features, text: textToAnalyze)
        let failure = { (error: Error) in print(error) }
        
        naturalLanguageUnderstanding.analyzeContent(withParameters: parameters, failure: failure) { (results : AnalysisResults) in
            
            if let theseResults = results.keywords {
                for results in theseResults {
                    if let text = results.text {
                        print("\(text), \(results.relevance!)")
                        completion(text)
                    }
                }
            }
        }
    }
    
    
    class func sentimentTest(textToAnalyze: String, completion: @escaping (Result) -> ()) {
        let username = Constants.userID
        let password = Constants.passwordID
        let version = Constants.versionDate
        
        let naturalLanguageUnderstanding = NaturalLanguageUnderstanding(username: username, password: password, version: version)
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
                        
                        completion(.sentiment(score))
                    }
                }
            }
        }
    }
}




