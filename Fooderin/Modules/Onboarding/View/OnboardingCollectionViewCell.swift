//
//  OnboardingCollectionViewCell.swift
//  Fooderin
//
//  Created by Алексей Павленко on 19.09.2022.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    static let identifier = "OnboardingCollectionViewCell"
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLabel: UILabel!
    @IBOutlet weak var slideDescriptionLabel: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = UIImage(named: slide.imageName)
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
    }
}
