//
//  MissionTrilogyTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class MissionTrilogyTableViewController: MissionBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        results = realm.objects(MissionInfo.self).filter("type = 'Trilogy'")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return results.count / 6
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return results[section * 6].section
    }
}

extension MissionTrilogyTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "TRILOGY")
    }
}
