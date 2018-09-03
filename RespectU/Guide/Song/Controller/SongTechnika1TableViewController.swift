//
//  SongTechnika1TableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SongTechnika1TableViewController: SongBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.songResults = self.songResults?.filter { $0.series == Series.technika1 }
    }
}

extension SongTechnika1TableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "TECHNIKA 1")
    }
}
