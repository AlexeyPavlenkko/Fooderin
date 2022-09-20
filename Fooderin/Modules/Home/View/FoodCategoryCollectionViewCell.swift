//
//  FoodCategoryCollectionViewCell.swift
//  Fooderin
//
//  Created by Алексей Павленко on 20.09.2022.
//

import UIKit
import Kingfisher

class FoodCategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "FoodCategoryCollectionViewCell"
    
    //MARK: - Outlets & Subviews
    private let foodCategoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray5
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = HomeConstants.cournerRadius
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.contentMode = .scaleToFill
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
        setupLayerAndShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        setupLayerAndShadow()
    }
    
    //MARK: - Private Methods
    private func initialSetup() {
        stackView.addArrangedSubview(foodCategoryImageView)
        stackView.addArrangedSubview(titleLabel)
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

            foodCategoryImageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1),
            foodCategoryImageView.widthAnchor.constraint(equalTo: foodCategoryImageView.heightAnchor, multiplier: 1)
        ])
    }
    
    private func setupLayerAndShadow() {
        backgroundColor = .cellBackground
        
        self.contentView.layer.cornerRadius = HomeConstants.cournerRadius
        self.contentView.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.shadow.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = HomeConstants.shadowRadius
        self.layer.shadowOpacity = HomeConstants.shadowOpacity
        self.layer.masksToBounds = false
        self.layer.cornerRadius = HomeConstants.cournerRadius
    }

    //MARK: - Public Methods
    public func setupCellWith(category: FoodCategory) {
        titleLabel.text = category.name
        foodCategoryImageView.kf.setImage(with: category.image?.asUrl, placeholder: UIImage(systemName: "network"))
    }
}
