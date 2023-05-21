//
//  FrameworkCell.swift
//  AppleFrameworkPractice
//
//  Created by YUJIN KWON on 2023/05/21.
//

import UIKit

class FrameworkCell: UICollectionViewCell {
    static let identifier = "FrameworkCell"
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(_ framework: AppleFramework) {
        thumbnailImage.image = UIImage(named: framework.imageName)
        titleLabel.text = framework.imageName
        
    }
}
