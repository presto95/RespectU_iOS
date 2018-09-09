//
//  SearchByLevelView.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 24..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class SearchByLevelView: UIView {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pickerView.selectRow(0, inComponent: 0, animated: true)
        pickerView.layer.borderWidth = 2
        pickerView.layer.borderColor = UIColor.main.cgColor
    }
}
