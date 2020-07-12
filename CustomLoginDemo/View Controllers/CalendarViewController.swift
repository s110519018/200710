//
//  CalendarViewController.swift
//  CustomLoginDemo
//
//  Created by ２１３ on 2020/7/9.
//  Copyright © 2020 ２１３. All rights reserved.
//
import UIKit
import FSCalendar

class CalendarViewController: UIViewController,FSCalendarDelegate, FSCalendarDataSource {
    var datesWithEvent = ["2020-07-05", "2020-07-06", "2020-07-12", "2020-07-25"]

    var datesWithMultipleEvents = ["2020-07-08", "2020-07-16", "2020-07-20", "2020-07-28"]
    @IBOutlet var calendar: FSCalendar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.select(Date())
        calendar.scope = .week
        calendar.accessibilityIdentifier = "calender"
        
    }
 
    //設定日期格式
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    // 點了會印出日期
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY at h:mm a"
        let string = formatter.string(from: date)
        print("\(string)")
    }
    //事件圖片
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {

        let dateString = self.dateFormatter2.string(from: date)

        if self.datesWithEvent.contains(dateString) {
            return UIImage(named: "dot")
        }

        if self.datesWithMultipleEvents.contains(dateString) {
            return UIImage(named: "dot")
        }

        return nil
    }
//    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
//            self.calendarHeightConstraint.constant = bounds.height
//            self.view.layoutIfNeeded()
//    }
    

}

