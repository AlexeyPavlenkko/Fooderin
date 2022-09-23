//
//  ListOfOrdersViewController.swift
//  Fooderin
//
//  Created by Алексей Павленко on 21.09.2022.
//

import UIKit

class ListOfOrdersViewController: UIViewController {
    
    //MARK: - Outlets & Subviews
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    public var orders: [Order] = []
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Orders"
        setupTableView()
        sendRequest()
    }
    
    //MARK: - Private Methods
    private func setupTableView() {
        tableView.register(DishTableViewCell.self, forCellReuseIdentifier: DishTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
    }
    
    private func sendRequest() {
        let ordersRequest = FetchOrdersRequest()
        ProgressIndication.show(on: self)
        NetworkService.shared.send(request: ordersRequest) { [weak self] result in
            switch result {
            case .success(let orders):
                self?.orders = orders
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    ProgressIndication.remove()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    ProgressIndication.remove()
                    self?.showErrorAlert(with: error.localizedDescription, completionAction: nil)
                }
            }
        }
    }
}

//MARK: - UITableViewDelegate & DataSource
extension ListOfOrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DishTableViewCell.identifier, for: indexPath) as! DishTableViewCell
        cell.setupCellWith(order: orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dish = orders[indexPath.row].dish
        let controller = DishDetailViewController.instantiate() as! DishDetailViewController
        controller.dish = dish
        controller.isOrderMode = false
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - Storyboarded
extension ListOfOrdersViewController: Storyboarded {
    static var storyboardName: String {
        "Main"
    }
    
    static var identifier: String {
        "ListOfOrdersViewController"
    }
}
