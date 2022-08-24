//
//  ShoppingTableViewCell.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/07/19.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var checkLabel: UILabel!
    @IBOutlet weak var starBtn: UIButton!

    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    @IBAction func checkmarkTapped(_ sender: UIButton) {
        if checkBtn.isSelected == true {
            checkBtn.isSelected = false
        } else {
            checkBtn.isSelected = true
        }
    }
    
    @IBAction func starTapped(_ sender: UIButton) {
        if starBtn.isSelected == true {
            starBtn.isSelected = false
        } else {
            starBtn.isSelected = true
        }
    }
    
}
