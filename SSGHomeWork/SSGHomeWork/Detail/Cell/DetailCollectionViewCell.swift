//
//  DetailCollectionViewCell.swift
//  SSGHomeWork
//
//  Created by YoungD on 2019. 8. 14..
//  Copyright © 2019년 YoungD. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailSubTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.initView()
    }
    
    /// 초기뷰 셋팅
    func initView(){
        self.detailTitleLabel.lineBreakMode = .byWordWrapping
        self.detailTitleLabel.numberOfLines = 0
        
        self.detailSubTitleLabel.lineBreakMode = .byWordWrapping
        self.detailSubTitleLabel.numberOfLines = 0
    }
    
    /// 셀 데이터 셋팅
    ///
    /// - Parameter detailData:
    func configureCell(detailData : ListDataModel){
        self.detailImageView.load(url: URL(string: detailData.itemImgUrl)!)
        self.detailTitleLabel.text = detailData.itemNm
        
        //3,480원 Display를 위해 추가 String -> Double -> Number -> String
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let price = Double(detailData.displayPrc)
        self.detailSubTitleLabel.text = "\(String(describing: numberFormatter.string(from: NSNumber(value : price!))!)) 원"
    }

}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
