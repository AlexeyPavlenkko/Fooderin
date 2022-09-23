//
//  ListOfDishesViewController.swift
//  Fooderin
//
//  Created by Алексей Павленко on 21.09.2022.
//

import UIKit

class ListOfDishesViewController: UIViewController {
    
    //MARK: - Outlets & Subviews
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    public var dishes: [Dish] = []
    
    public var category: FoodCategory!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
        setupTableView()
        sendNetworkRequest()
    }
    
    
    //MARK: - Private Methods
    private func initialSetup() {
        title = category.name
    }
    
    private func setupTableView() {
        tableView.register(DishTableViewCell.self, forCellReuseIdentifier: DishTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
    }
    
    private func sendNetworkRequest() {
        ProgressIndication.show(on: self)
        let listOfDishesRequest = CategoryDishesRequest(path: category.id ?? "-")
        NetworkService.shared.send(request: listOfDishesRequest) { [weak self] result in
            switch result {
            case .success(let dishes):
                self?.dishes = dishes
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    ProgressIndication.remove()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    ProgressIndication.remove()
                    self?.showErrorAlert(with: error.localizedDescription, completionAction: { _ in
                        self?.navigationController?.popViewController(animated: true)
                    })
                }
            }
        }
    }

    
}

//MARK: - UITableViewDelegate & DataSource
extension ListOfDishesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DishTableViewCell.identifier, for: indexPath) as! DishTableViewCell
        cell.setupCellWith(dish: dishes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = DishDetailViewController.instantiate() as! DishDetailViewController
        controller.dish = dishes[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - Storyboarded
extension ListOfDishesViewController: Storyboarded {
    static var storyboardName: String {
        "Main"
    }
    
    static var identifier: String {
        "ListOfDishesViewController"
    }
}
