//
//  ButtonCell.swift
//  SkyScapes
//
//  Created by Никита Абаев on 22.07.2024.
//

import UIKit

class ButtonCell: UICollectionViewCell {
    //MARK: - IBOutlets CollectionViewCell
    
    @IBOutlet  var button: UIButton!
    @IBOutlet weak var imageInBotton: UIImageView!
    
func configure(image: UIImage?, title: String, isSelected: Bool) {
   button.setTitle(title, for: .normal)
   imageInBotton.image = image
   contentView.layer.cornerRadius = 16
   contentView.layer.borderWidth = isSelected ? 2 : 0
   contentView.layer.borderColor = isSelected ? UIColor.white.cgColor : UIColor.clear.cgColor
}
    
    //MARK: - View lifeCycle
override  func awakeFromNib() {
    super.awakeFromNib()
    contentView.layer.cornerRadius = 16
    }
}
