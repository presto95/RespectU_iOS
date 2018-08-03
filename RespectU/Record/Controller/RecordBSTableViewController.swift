//
//  RecordBSTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 6. 28..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class RecordBSTableViewController: RecordBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.results = RecordInfo.get().filter(key: "series", value: Series.bs, method: FilterOperator.equal).sorted(byKeyPath: "lowercase")
    }
}

extension RecordBSTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "BLACK SQUARE")
    }
}

