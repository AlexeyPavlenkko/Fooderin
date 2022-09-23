//
//  ChefsSpecialsCollectionViewCell.swift
//  Fooderin
//
//  Created by Алексей Павленко on 20.09.2022.
//

import UIKit

class ChefsSpecialsCollectionViewCell: UICollectionViewCell {
    static let identifier = "ChefsSpecialsCollectionViewCell"
    
    //MARK: - Outlets & Subviews
    private let chefsSpecialImageView: UIImageView = {
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
        lbl.font = .systemFont(ofSize: 15, weight: .medium)
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setContentHuggingPriority(.required, for: .vertical)
        return lbl
    }()
    
    private let caloriesLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.textColor = .main
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setContentHuggingPriority(.required, for: .vertical)
        return lbl
    }()
    
    private let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12)
        lbl.textColor = .systemGray
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 5
        stack.axis = .vertical
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
    
    private func initialSetup() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(caloriesLabel)
        addSubview(chefsSpecialImageView)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            chefsSpecialImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            chefsSpecialImageView.widthAnchor.constraint(equalTo: chefsSpecialImageView.heightAnchor),
            chefsSpecialImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            chefsSpecialImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: chefsSpecialImageView.trailingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: chefsSpecialImageView.topAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: chefsSpecialImageView.bottomAnchor, constant: 0)
        ])
    }
    
    //MARK: - Public Methods
    public func setupCellWith(chefsSpecial: Dish) {
        titleLabel.text = chefsSpecial.name
        caloriesLabel.text = chefsSpecial.formattedCalories
        descriptionLabel.text = chefsSpecial.description
        chefsSpecialImageView.kf.setImage(with: chefsSpecial.image?.asUrl)
    }
}
