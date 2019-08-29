//
//  AlertTableViewCell.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/28.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

import UIKit

class AlertTableViewCell: UITableViewCell {


    @IBOutlet var alertTextLabel: UILabel!

//    var item: NSDictionary?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        alertTextLabel.text = item?["likeUser"] as? String
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func set(nameList: [String], num: Int) {
//        guard let likeuser = dict["likeUser"] else { return }

//        alertTextLabel.text = likeuser as? String
        alertTextLabel.text = nameList[num]

    }

}
