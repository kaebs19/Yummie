//
//  CategoryCollectionViewCell.swift
//  Yummie
//
//  Created by mjeed on 26/09/2023.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLable: UILabel!
    
    
    // MARK: - func
    
    func setup(categry: DishCategry) {
        categoryTitleLable.text = categry.name
        categoryImageView.kf.setIma
    }
    
    
}
