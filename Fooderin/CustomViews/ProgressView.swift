//
//  ProgressView.swift
//  Fooderin
//
//  Created by Алексей Павленко on 22.09.2022.
//

import UIKit

class ProgressView: UIView {
    private let containerView: UIView = {
        let container = UIView()
        container.frame.size = CGSize(width: 100, height: 100)
        container.backgroundColor = .cellBackground
        return container
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityInd = UIActivityIndicatorView(style: .large)
        activityInd.color = .shadow
        activityInd.hidesWhenStopped = true
        return activityInd
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerView)
        addSubview(activityIndicator)
        setupShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupShadow()
    }
    
    public func show() {
        containerView.center = center
        activityIndicator.center = center
        activityIndicator.startAnimating()
    }
    
    private func setupShadow() {
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.shadow.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        containerView.layer.shadowRadius = 10
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.masksToBounds = false
    }
}

struct ProgressIndication {
    private static var progressView: ProgressView!
    
    public static func show(on viewController: UIViewController, isBackgroundVisible: Bool = true) {
        progressView?.removeFromSuperview()
        progressView = ProgressView(frame: viewController.view.bounds)
        progressView.backgroundColor = isBackgroundVisible ? .background : .clear
        viewController.view.addSubview(progressView)
        progressView.show()
    }
    
    public static func remove() {
        progressView.removeFromSuperview()
    }
}
