//
//  SearchRecordDetailCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 19..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import RealmSwift

final class SearchRecordDetailCell: UITableViewCell {
  
  @IBOutlet weak var colorLabel: UILabel!
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var difficultyLabel: UILabel!
  
  @IBOutlet weak var rateLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    colorLabel.layer.cornerRadius = colorLabel.bounds.width / 2
    colorLabel.layer.masksToBounds = true
  }
  
  func setProperties(_ object: SearchRecordDetail) {
    let gradient = object.series.seriesGradient(.vertical) ?? CAGradientLayer()
    gradient.frame = colorLabel.bounds
    colorLabel.layer.addSublayer(gradient)
    titleLabel.text = object.title
    difficultyLabel.text = object.difficulty.uppercased()
    rateLabel.text = "\(object.rate)%"
  }
}
