//
//  DownloadViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class DownloadViewController: UIViewController {

    @IBOutlet weak var downloadDataLabel: UILabel!
    @IBOutlet weak var downloadDataButton: UIButton!
    @IBOutlet weak var downloadRecordLabel: UILabel!
    @IBOutlet weak var downloadRecordButton: UIButton!
    var finishesSong: Bool = false
    var finishesMission: Bool = false
    var finishesTrophy: Bool = false
    var finishesAchievement: Bool = false
    var finishesTip: Bool = false
    var finishesVersion: Bool = false
    var finishesRecord: Bool = false
    var dataCount = 0 {
        didSet {
            if dataCount == 6 {
                hideIndicator()
                if finishesDataAll {
                    presentSuccessAlert()
                } else {
                    presentFailureAlert()
                }
            }
        }
    }
    var recordCount = 0 {
        didSet {
            if recordCount == 1 {
                hideIndicator()
                if finishesRecord {
                    presentSuccessAlert()
                } else {
                    presentFailureAlert()
                }
            }
        }
    }
    var finishesDataAll: Bool {
        if finishesSong, finishesMission, finishesTrophy, finishesAchievement, finishesTip, finishesVersion {
            return true
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.downloadDataButton.layer.cornerRadius = 10
        self.downloadDataButton.backgroundColor = .main
        self.downloadRecordButton.layer.cornerRadius = 10
        self.downloadRecordButton.backgroundColor = .main
        self.downloadDataLabel.text = "Renew with latest data.".localized
        self.downloadRecordLabel.text = "Get exported performance record data.".localized
        self.downloadDataButton.setTitle("Download".localized, for: [])
        self.downloadRecordButton.setTitle("Download", for: [])
        self.downloadDataButton.addTarget(self, action: #selector(touchUpDownloadDataButton(_:)), for: .touchUpInside)
        self.downloadRecordButton.addTarget(self, action: #selector(touchUpDownloadRecordButton(_:)), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveSongs(_:)), name: .didReceiveSongs, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMissions(_:)), name: .didReceiveMissions, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveTrophies(_:)), name: .didReceiveTrophies, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveAchievements(_:)), name: .didReceiveAchievements, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveTips(_:)), name: .didReceiveTips, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveVersions(_:)), name: .didReceiveVersions, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveSongs(_:)), name: .errorReceiveSongs, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveMissions(_:)), name: .errorReceiveMissions, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveTrophies(_:)), name: .errorReceiveTrophies, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveAchievements(_:)), name: .errorReceiveAchievements, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveTips(_:)), name: .errorReceiveTips, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveVersions(_:)), name: .errorReceiveVersions, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveRecords(_:)), name: .didReceiveRecords, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveRecords(_:)), name: .errorReceiveRecords, object: nil)
    }
    
    @objc func touchUpDownloadDataButton(_ sender: UIButton) {
        showIndicator()
        API.requestSongs()
        API.requestMissions()
        API.requestTrophies()
        API.requestAchievements()
        API.requestTips()
        API.requestVersions()
    }
    
    @objc func touchUpDownloadRecordButton(_ sender: UIButton) {
        showIndicator()
        API.requestRecords()
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DownloadViewController {
    @objc func didReceiveSongs(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["songs"] as? SongResponse else { return }
        let downloadedSongs = userInfo.songs
        let results = SongInfo.fetch()
        for downloadedSong in downloadedSongs {
            let predicate = NSPredicate(format: "%K == %@", #keyPath(SongInfo.title.english), downloadedSong.title.english)
            if let result = results.filter(predicate).first {
                SongInfo.update(downloadedSong, to: result)
            } else {
                SongInfo.add(downloadedSong)
            }
        }
    }
    
    @objc func didReceiveMissions(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["missions"] as? MissionResponse else { return }
        let downloadedMissions = userInfo.missions
        let results = MissionInfo.fetch()
        for downloadedMission in downloadedMissions {
            let predicate = NSPredicate(format: "%K == %@", #keyPath(MissionInfo.title), downloadedMission.title)
            if let result = results.filter(predicate).first {
                MissionInfo.update(downloadedMission, to: result)
            } else {
                MissionInfo.add(downloadedMission)
            }
        }
    }
    
    @objc func didReceiveTrophies(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["trophies"] as? TrophyResponse else { return }
        let downloadedTrophies = userInfo.trophies
        let results = TrophyInfo.fetch()
        for downloadedTrophy in downloadedTrophies {
            let predicate = NSPredicate(format: "%K == %@", #keyPath(TrophyInfo.image), downloadedTrophy.image)
            if let result = results.filter(predicate).first {
                TrophyInfo.update(downloadedTrophy, to: result)
            } else {
                TrophyInfo.add(downloadedTrophy)
            }
        }
    }
    
    @objc func didReceiveAchievements(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["achievements"] as? AchievementResponse else { return }
        let downloadedAchievements = userInfo.achievements
        let results = AchievementInfo.fetch()
        for downloadedAchievement in downloadedAchievements {
            let predicate = NSPredicate(format: "%K == %@ AND %K == %@", #keyPath(AchievementInfo.item.english), downloadedAchievement.item.english, #keyPath(AchievementInfo.type), downloadedAchievement.type)
            if let result = results.filter(predicate).first {
                AchievementInfo.update(downloadedAchievement, to: result)
            } else {
                AchievementInfo.add(downloadedAchievement)
            }
        }
    }
    
    @objc func didReceiveTips(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["tips"] as? TipResponse else { return }
        let downloadedTips = userInfo.tips
        let results = TipInfo.fetch()
        for downloadedTip in downloadedTips {
            let predicate = NSPredicate(format: "%K == %@", #keyPath(TipInfo.title.english), downloadedTip.title.english)
            if let result = results.filter(predicate).first {
                TipInfo.update(downloadedTip, to: result)
            } else {
                TipInfo.add(downloadedTip)
            }
        }
    }
    
    @objc func didReceiveVersions(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["versions"] as? VersionResponse else { return }
        if let result = VersionInfo.fetch().first {
            VersionInfo.update(userInfo, to: result)
        } else {
            VersionInfo.add(userInfo)
        }
        finishesVersion = true
        plusDataCount()
    }
    
    @objc func didReceiveRecords(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["records"] as? RecordResponse else { return }
        //
        finishesRecord = true
        plusRecordCount()
    }
    
    @objc func errorReceiveSongs(_ notification: Notification) {
        plusDataCount()
    }
    
    @objc func errorReceiveMissions(_ notification: Notification) {
        plusDataCount()
    }
    
    @objc func errorReceiveTrophies(_ notification: Notification) {
        plusDataCount()
    }
    
    @objc func errorReceiveAchievements(_ notification: Notification) {
        plusDataCount()
    }
    
    @objc func errorReceiveTips(_ notification: Notification) {
        plusDataCount()
    }
    
    @objc func errorReceiveVersions(_ notification: Notification) {
        plusDataCount()
    }
    
    @objc func errorReceiveRecords(_ notification: Notification) {
        plusRecordCount()
    }
}

extension DownloadViewController {
    private func presentSuccessAlert() {
        UIAlertController
            .alert(title: "", message: "Your data has been successfully downloaded.".localized)
            .defaultAction(title: "OK".localized) { [weak self] _ in
                self?.parent?.dismiss(animated: true, completion: nil)
            }
            .present(to: self)
    }
    
    private func presentFailureAlert() {
        UIAlertController
            .alert(title: "", message: "Network Error".localized)
            .defaultAction(title: "OK".localized) { [weak self] _ in
                self?.dataCount = 0
            }
            .present(to: self)
    }
    
    private func plusDataCount() {
        DispatchQueue.main.sync { [weak self] in
            self?.dataCount += 1
        }
    }
    
    private func plusRecordCount() {
        DispatchQueue.main.sync { [weak self] in
            self?.recordCount += 1
        }
    }
}


