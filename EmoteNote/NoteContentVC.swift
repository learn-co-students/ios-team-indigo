//
//  NoteContentVC.swift
//  EmoteNote
//
//  Created by William Leahy on 4/21/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import UIKit
import Charts

class NoteContentVC: UIViewController, IAxisValueFormatter {
    
    let store = NoteDataStore.sharedInstance
    
    let font = UIFont(name: "Cabin-Bold", size: 12)
    
    var selectedNote : Note!
    
    var emotionIndex = ["Anger", "Sadness", "Joy", "Fear", "Digust"]
    var emotionIndexValue : [Double] = []
    
    @IBOutlet weak var noteContentTextView: UITextView!
    @IBOutlet weak var barChartView: BarChartView!
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emotionIndexValue = setEmotionIndexes()
        print(emotionIndexValue)
        setChartItem()
        setColor()
        setNoteViewConstraints()
        setNoteData()
        axisFormatDelegate = self
        setChart(dataPoints: emotionIndex, values: emotionIndexValue)
        
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
    
    func setNoteStyling() {
        print("i am styling")
        self.noteContentTextView.font = font
    }
    
    func setChartItem() {
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
    
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "There is no data currently available for the current day"
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let labelString = dataPoints[i]
            let label = NSString(string: labelString)
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i], data: label)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Emotion Index")
        let chartData = BarChartData(dataSet: chartDataSet)
        
        var colorsArray: [UIColor] = []
        
        
        // makes colors random by appending arc'd colors to the colors array > which are used to populate the color of the bars
        // # makes the colors standard
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colorsArray.append(color)
        }
        
        chartDataSet.colors = colorsArray
        
        barChartView.data = chartData
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:emotionIndex)
        barChartView.xAxis.granularity = 1
        
        barChartView.chartDescription?.text = ""
        barChartView.leftAxis.axisMaximum = 1.0
        barChartView.rightAxis.axisMaximum = 1.0
        
        // MARK : animation
        let animationDouble = 1.5
        barChartView.animate(xAxisDuration: animationDouble, yAxisDuration: animationDouble)
        
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return emotionIndex[Int(value)]
    }
    
    
}
