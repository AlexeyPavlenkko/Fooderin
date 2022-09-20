//
//  HeaderCollectionReusableView.swift
//  Fooderin
//
//  Created by Алексей Павленко on 20.09.2022.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    static let kind = "header"
    static let identifier = "HeaderCollectionReusableView"
    
    private let headerLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .shadow
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 25, weight: .medium)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerLabel)
        setupConstaints()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstaints() {
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    public func setupHeader(with title: String) {
        headerLabel.text = title
    }
}
