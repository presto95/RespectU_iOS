//
//  TrophyLinkDiskTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 6. 28..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class TrophyLinkDiskTableViewController: TrophyBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        results = realm.objects(TrophyInfo.self).filter("series = '\(Series.linkDisk)'")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = super.tableView(tableView, cellForRowAt: indexPath) as? TrophyCell else { return UITableViewCell() }
        let imageName = "linkdisk\(indexPath.row + 1)"
        cell.trophyImageView.image = UIImage(named: imageName)
        return cell
    }
}

extension TrophyLinkDiskTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "LINK DISK")
    }
}
