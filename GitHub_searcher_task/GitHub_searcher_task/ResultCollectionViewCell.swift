//
//  ResultCollectionViewCell.swift
//  GitHub_Searcher
//
//  Created by edisonlin on 2022/3/6.
//

import UIKit
import Kingfisher

class ResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUI(name: String, avatar: String) {
        if let url = URL(string: avatar) {
            avatarImageView.kf.setImage(with: url)
        }
        accountNameLabel.text = name
    }
    

}
