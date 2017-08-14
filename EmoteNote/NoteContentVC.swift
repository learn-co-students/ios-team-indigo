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
    
    var selectedNote : Note!
    var gradientLayer : CAGradientLayer!
    
    var emotionIndex = ["Anger", "Sadness", "Joy", "Fear", "Digust"]
    var emotionIndexValue : [Double] = []
    
    @IBOutlet weak var noteContentTextView: UITextView!
    @IBOutlet weak var barChartView: BarChartView!
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        emotionIndexValue = setEmotionIndexes()
        print(emotionIndexValue)
        setChartItem()
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
        noteContentTextView.setContentOffset(CGPoint.zero, animated: false)
        noteContentTextView.backgroundColor = UIColor.clear
    }
    
    // MARK : Need keyword content
    
    func setChartItem() {
        barChartView.noDataTextColor = UIColor.red
        barChartView.backgroundColor = UIColor.clear
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
        
        // sets color of bars
        let colorsArray: [UIColor] = [ColorPallet.angerColor, ColorPallet.sadnessColor, ColorPallet.joyColor, ColorPallet.fearColor, ColorPallet.disgustColor]
        chartDataSet.colors = colorsArray // anger, sadness, joy, fear, disgust
        
        // MARK : antiquated random color generator
        
        //        for _ in 0..<dataPoints.count {
        //            let red = Double(arc4random_uniform(256))
        //            let green = Double(arc4random_uniform(256))
        //            let blue = Double(arc4random_uniform(256))
        //
        //            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        //            colorsArray.append(color)
        //        }
        
        
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
