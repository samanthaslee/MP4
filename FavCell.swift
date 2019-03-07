//
//  FavCell.swift
//  MP4
//
//  Created by Elizabeth Lee on 3/5/19.
//  Copyright © 2019 Sam Lee. All rights reserved.
//

import Foundation

import UIKit

class FavCell: UITableViewCell {
    var favLabel : UILabel!
    var favDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favLabel = UILabel(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height * 2 / 3))
        //favLabel.center = CGPoint(x: 100, y: contentView.frame.height / 2)
        favLabel.textAlignment = .center
        favDateLabel = UILabel(frame: CGRect(x: 0, y: (contentView.frame.height * 2 / 3), width: contentView.frame.width, height: contentView.frame.height / 3))
        favDateLabel.textAlignment = .center
        contentView.addSubview(favLabel)
        contentView.addSubview(favDateLabel)
    }
    
}
