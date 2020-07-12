//
//  AnalysisViewController.swift
//  CustomLoginDemo
//
//  Created by ２１３ on 2020/7/8.
//  Copyright © 2020 ２１３. All rights reserved.
//

import UIKit
import Charts

class AnalysisViewController: UIViewController, ChartViewDelegate{

    var lineChart = LineChartView()
    
    var barChart = BarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.delegate = self
        barChart.delegate = self
        
        LineChartFunc()
        BarChartFunc()
    }
    
    func LineChartFunc() {
        
        lineChart.frame = CGRect(x: 0,y: 0, width: self.view.frame.size.width/4*3, height: self.view.frame.size.width/4*3)
        
        lineChart.center = CGPoint(x: self.view.frame.size.width/2, y:self.view.frame.size.width/3*2)
        
        view.addSubview(lineChart)
        
        var entries = [ChartDataEntry]()
        
        for x in 0..<6 {
            entries.append(ChartDataEntry(x: Double(x), y: Double(x)))
        }
        
        let set = LineChartDataSet(entries: entries)
        
        set.colors = ChartColorTemplates.material()
        
        let data = LineChartData(dataSet: set)
        
        lineChart.data = data
    }
    
    func BarChartFunc() {
    
        barChart.frame = CGRect(x: 0,y: 0, width: self.view.frame.size.width/4*3, height: self.view.frame.size.width/4*3)

        barChart.center = CGPoint(x: self.view.frame.size.width/2, y:self.view.frame.size.width/2*3)

        view.addSubview(barChart)

        var entries = [BarChartDataEntry]()

        for x in 0..<6 {
            entries.append(BarChartDataEntry(x: Double(x), y: Double(x)))
        }

        let set = BarChartDataSet(entries: entries)

        set.colors = ChartColorTemplates.joyful()

        let data = BarChartData(dataSet: set)

        barChart.data = data

    }
}
