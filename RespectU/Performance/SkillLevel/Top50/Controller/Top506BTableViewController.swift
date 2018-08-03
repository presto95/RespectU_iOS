//
//  Top506BTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class Top506BTableViewController: Top50BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.results = RecordInfo.get().sorted(byKeyPath: "button6SkillPoint", ascending: false)
    }
}

extension Top506BTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: Buttons.button6)
    }
}
