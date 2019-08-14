//
//  mainTableViewCell.swift
//  SSGHomeWork
//
//  Created by YoungD on 2019. 8. 14..
//  Copyright © 2019년 YoungD. All rights reserved.
//

import UIKit

class mainTableViewCell: UITableViewCell {

    @IBOutlet weak var mainTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// 2019. 08. 14. youngji
    /// 테이블 뷰 셋팅
    /// - Parameter titleData:
    func configureCell(titleData : String){
        mainTitleLabel.text = titleData
    }

}
