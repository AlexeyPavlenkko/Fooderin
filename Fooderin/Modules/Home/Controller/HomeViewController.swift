//
//  HomeViewController.swift
//  Fooderin
//
//  Created by Алексей Павленко on 19.09.2022.
//

import UIKit


class HomeViewController: UIViewController {
    enum Section: String, CaseIterable {
        case foodCategory = "Food Category"
        case popularDishes = "Popular Dishes"
        case chefsSpecial = "Chef's Specials"
    }
    
    //MARK: - Outlets & Subviews
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Variables
    private var foodCategories: [FoodCategory] = [
        .init(id: "1", name: "Test1 Dishes", image: "https://picsum.photos/200/200"),
        .init(id: "2", name: "Test2 Dishes", image: "https://picsum.photos/200/200"),
        .init(id: "3", name: "Test3 Dishes", image: "https://picsum.photos/200/200"),
        .init(id: "4", name: "Test4 Dishes", image: "https://picsum.photos/200/200"),
        .init(id: "6", name: "Test6 Dishes", image: "https://picsum.photos/200/200"),
        .init(id: "5", name: "Test5 Dishes", image: "https://picsum.photos/200/200"),
    ]
    
    private var popularDishes: [Dish] = [
        .init(id: "1", name: "Test1 Dishes", description: "BDSFlahbalblah", image: "https://picsum.photos/200/400", calories: 10),
        .init(id: "2", name: "Test2 Dishes", description: "blahbalblah", image: "https://picsum.photos/200/400", calories: 10),
        .init(id: "3", name: "Test3 Dishes", description: "blahbalblah", image: "https://picsum.photos/200/400", calories: 10),
        .init(id: "4", name: "Test4 Dishes", description: "blahbalblah", image: "https://picsum.photos/200/400", calories: 10),
        .init(id: "6", name: "Test6 Dishes", description: "blahbalblah", image: "https://picsum.photos/200/400", calories: 10),
        .init(id: "5", name: "Test5 Dishes", description: "blahbalblah", image: "https://picsum.photos/200/400", calories: 10),
    ]
    
    private var chefsSpecials: [Dish] = [
        .init(id: "6", name: "Test6 Dishes", description: "blahbalblah", image: "https://picsum.photos/100/100", calories: 10),
        .init(id: "5", name: "Test5 Dishes", description: "blahbalblah", image: "https://picsum.photos/100/100", calories: 10)
    ]
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confugireNavBar()
        configureCollectionView()
    }
    
    //MARK: - Actions & @objc
    @objc private func cartBarButtonDidTapped() {
        print("Cart was tapped")
    }
    
    //MARK: - Methods
    private func confugireNavBar() {
        title = "Fooderin"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart.circle.fill"), style: .plain, target: self, action: #selector(cartBarButtonDidTapped))
        navigationItem.rightBarButtonItem?.tintColor = .main
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .semibold)]
    }

    private func configureCollectionView() {
        collectionView.register(FoodCategoryCollectionViewCell.self, forCellWithReuseIdentifier: FoodCategoryCollectionViewCell.identifier)
        collectionView.register(PopularDishesCollectionViewCell.self, forCellWithReuseIdentifier: PopularDishesCollectionViewCell.identifier)
        collectionView.register(ChefsSpecialsCollectionViewCell.self, forCellWithReuseIdentifier: ChefsSpecialsCollectionViewCell.identifier)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: HeaderCollectionReusableView.kind, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collectionView.collectionViewLayout = HomeCompositionalLayout.createLayout(with: Section.allCases)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section.allCases[section] {
        case .foodCategory: return foodCategories.count
        case .popularDishes: return popularDishes.count
        case .chefsSpecial: return chefsSpecials.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = Section.allCases[indexPath.section]
        switch section {
        case .foodCategory:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCategoryCollectionViewCell.identifier, for: indexPath) as! FoodCategoryCollectionViewCell
            let foodCategory = foodCategories[indexPath.row]
            cell.setupCellWith(category: foodCategory)
            return cell
        case .popularDishes:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularDishesCollectionViewCell.identifier, for: indexPath) as! PopularDishesCollectionViewCell
            let popularDish = popularDishes[indexPath.row]
            cell.setupCellWith(dish: popularDish)
            return cell
        case .chefsSpecial:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChefsSpecialsCollectionViewCell.identifier, for: indexPath) as! ChefsSpecialsCollectionViewCell
            let special = chefsSpecials[indexPath.row]
            cell.setupCellWith(chefsSpecial: special)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: HeaderCollectionReusableView.kind, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        let headerTitle = Section.allCases[indexPath.section].rawValue
        headerView.setupHeader(with: headerTitle)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("Did tapped at index path: \(indexPath)")
    }

}

//MARK: - Storyboarded
extension HomeViewController: Storyboarded {
    static var storyboardName: String {
        "Main"
    }
    
    static var identifier: String {
        "HomeViewController"
    }
}
