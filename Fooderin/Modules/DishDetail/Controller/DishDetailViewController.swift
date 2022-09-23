//
//  DishDetailViewController.swift
//  Fooderin
//
//  Created by Алексей Павленко on 21.09.2022.
//

import UIKit

class DishDetailViewController: UIViewController {

    //MARK: - Outlets & Subviews
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var placeOrderButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    //MARK: - Variables
    public var dish: Dish!
    public var isOrderMode: Bool = true
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
    }
    
    //MARK: - Actions & @objc
    @objc private func placeOrderButtonClicked() {
        guard let name = nameTextField.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty else {
            showErrorAlert(with: "Please enter your name") {[weak self] _ in
                self?.nameTextField.becomeFirstResponder()
            }
            return 
        }
        ProgressIndication.show(on: self, isBackgroundVisible: false)
        let placeOrderRequest = PlaceOrderRequest(dishID: dish.id ?? "", name: name)
        NetworkService.shared.send(request: placeOrderRequest) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    ProgressIndication.remove()
                    self?.showSuccessAlert(with: "Order has been made!👨‍🍳👩‍🍳")
                    self?.nameTextField.text = ""
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    ProgressIndication.remove()
                    self?.showErrorAlert(with: error.localizedDescription, completionAction: { _ in
                        self?.nameTextField.text = ""
                        self?.nameTextField.becomeFirstResponder()
                    })
                }
            }
        }
    }
    
    //MARK: - Private Methods
    private func initialSetup() {
        placeOrderButton.layer.cornerRadius = DishDetailConstants.cornerRadius
        placeOrderButton.addTarget(self, action: #selector(placeOrderButtonClicked), for: .touchUpInside)
        nameTextField.layer.cornerRadius = DishDetailConstants.cornerRadius
        NSLayoutConstraint(item: stackView!, attribute: .bottom, relatedBy: .equal, toItem: view.keyboardLayoutGuide, attribute: .top, multiplier: 1, constant: -16).isActive = true
        
        dishNameLabel.text = dish.name
        caloriesLabel.text = dish.formattedCalories
        descriptionLabel.text = dish.description
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        nameTextField.delegate = self
        nameTextField.isHidden = !isOrderMode
        placeOrderButton.isHidden = !isOrderMode
    }
}

//MARK: - UITextFieldDelegate
extension DishDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - Storyboarded
extension DishDetailViewController: Storyboarded {
    static var storyboardName: String {
        "Main"
    }
    
    static var identifier: String {
        "DishDetailViewController"
    }
}
