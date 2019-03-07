//
//  Ranking5BTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import SVProgressHUD
import XLPagerTabStrip

final class Ranking5BTableViewController: RankingBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    SVProgressHUD.show()
    API.requestRankings { response, error in
      if let error = error {
        UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
        return
      }
      guard let response = response else { return }
      self.results = response.rankings.sorted { $0.button5 > $1.button5 }
      DispatchQueue.main.async { [weak self] in
        self?.tableView.reloadData()
        SVProgressHUD.dismiss()
      }
    }
  }
}

extension Ranking5BTableViewController {
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? RankingCell else { return UITableViewCell() }
    cell.configure(results, at: indexPath.row, button: Buttons.button5)
    return cell
  }
}

extension Ranking5BTableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: Buttons.button5.uppercased())
  }
}
