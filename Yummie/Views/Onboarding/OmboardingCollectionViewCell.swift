//
//  OmboardingCollectionViewCell.swift
//  Yummie
//
//  Created by mjeed on 18/09/2023.
//

import UIKit

class OmboardingCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets

    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLable: UILabel!
    @IBOutlet weak var slideDescriptionLable: UILabel!
    
    // MARK: - Variables
    static let identifier = String(describing: OmboardingCollectionViewCell.self )
    
    
    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitleLable.text = slide.title
        slideDescriptionLable.text = slide.description
    }
}
