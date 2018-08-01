//
//  TrophyRespectTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class TrophyRespectTableViewController: TrophyBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        results = realm.objects(TrophyInfo.self).filter("series = '\(Series.respect)'")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = super.tableView(tableView, cellForRowAt: indexPath) as? TrophyCell else { return UITableViewCell() }
        let imageName = "respect\(indexPath.row + 1)"
        cell.trophyImageView.image = UIImage(named: imageName)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        let title: String
        let message: String
        if row == 36 || row == 37 {
            title = "Hidden BGAs".localized
            message = "A Lie\nEnemy Storm\nNB RANGER - Virgin Force\nNever Say\nWhiteBlue\nOut Law"
            UIAlertController
                .alert(title: title, message: message)
                .defaultAction(title: "OK".localized)
                .present(to: self)
        }
        else if row == 26 {
            title = "777 Combos".localized
            message = "5B NORMAL [Seeker]\n47 Combos -> BREAK -> Full Combo -> Trophy Earned".localized
            UIAlertController
                .alert(title: title, message: message)
                .defaultAction(title: "OK".localized)
                .present(to: self)
        }
        else if row == 41 {
            title = "CREDITS".localized
            messsage = "CREDITS will appear when the average accuracy of three stages are greater than 98%.".localized
            UIAlertController
                .alert(title: title, message: message)
                .defaultAction(title: "OK".localized)
                .present(to: self)
        }
    }
}

extension TrophyRespectTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "RESPECT")
    }
}
