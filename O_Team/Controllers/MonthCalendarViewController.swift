//
//  MonthCalendarViewController.swift
//  O_Team
//
//  Created by 최지철 on 2023/06/10.
//

import UIKit
import SnapKit

class MonthCalendarViewController: UIViewController {
    var MonthLabel = UILabel()
    var preMonthBtn = UIButton()
    var postMonthBtn = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func setConfigure() {
        MonthLabel.text = "이번달 감정"
    }
    

}
