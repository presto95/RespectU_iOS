//
//  TrophyBaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift


class TrophyBaseTableViewController: BaseTableViewController {

    var results: TrophyResponse?
    let cellIdentifier = "trophyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showIndicator()
        self.tableView.rowHeight = 60
        self.tableView.register(UINib(nibName: "TrophyCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveTrophy(_:)), name: .didReceiveTrophies, object: nil)
    }
    
    @objc func didReceiveTrophy(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["trophies"] as? TrophyResponse else { return }
        self.results = userInfo
        DispatchQueue.main.async { [weak self] in
            self?.hideIndicator()
            self?.tableView.reloadData()
        }
        NotificationCenter.default.removeObserver(self, name: .didReceiveTrophies, object: nil)
    }
}

extension TrophyBaseTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TrophyCell else { return UITableViewCell() }
        let row = indexPath.row
        let count = self.results?.count ?? 0
        if row < count {
            let object = self.results?[indexPath.row]
            cell.setProperties(object)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
