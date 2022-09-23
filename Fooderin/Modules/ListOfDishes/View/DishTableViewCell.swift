//
//  DishTableViewCell.swift
//  Fooderin
//
//  Created by Алексей Павленко on 21.09.2022.
//

import UIKit

class DishTableViewCell: UITableViewCell {
    static let identifier = "DishTableViewCell"
    
    //MARK: - Outlets & Subviews
    private let dishImageView: UIImageView = {
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
    
    private let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 15)
        lbl.textColor = .systemGray
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
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
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .cellBackground
        return view
    }()
    
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        backgroundColor = .background
        
        containerView.layer.shadowColor = UIColor.shadow.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        containerView.layer.shadowRadius = ListOfDishesConstants.shadowRadius
        containerView.layer.shadowOpacity = ListOfDishesConstants.shadowOpacity
        containerView.layer.masksToBounds = false
        containerView.layer.cornerRadius = ListOfDishesConstants.cournerRadius
    }
    
    private func initialSetup() {
        addSubview(containerView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        containerView.addSubview(dishImageView)
        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            dishImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.7),
            dishImageView.widthAnchor.constraint(equalTo: dishImageView.heightAnchor),
            dishImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            dishImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: dishImageView.topAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: -10)
        ])
    }
    
    //MARK: - Public Methods
    public func setupCellWith(dish: Dish) {
        titleLabel.text = dish.name
        descriptionLabel.text = dish.description
        dishImageView.kf.setImage(with: dish.image?.asUrl)
    }
    
    public func setupCellWith(order: Order) {
        titleLabel.text = order.dish?.name
        descriptionLabel.text = order.name
        dishImageView.kf.setImage(with: order.dish?.image?.asUrl)
    }
}
