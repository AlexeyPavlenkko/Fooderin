//
//  OnboardingViewController.swift
//  Fooderin
//
//  Created by Алексей Павленко on 19.09.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    //MARK: - Outlets & Subviews
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    //MARK: - Variables
    private let slides: [OnboardingSlide] = OnboardingConstants.slides
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            updateNextButtonTitle()
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configurePageControll()
        configureNextButton()
    }
    
    //MARK: - Actions & @objc
    @IBAction private func nextButtonTapped(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let homeController = HomeViewController.instantiate()
            let navVC = UINavigationController(rootViewController: homeController)
            navVC.modalTransitionStyle = .flipHorizontal
            navVC.modalPresentationStyle = .fullScreen
            present(navVC, animated: true)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    //MARK: - Methods
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configureNextButton() {
        nextButton.layer.cornerRadius = OnboardingConstants.cornerRadius
    }
    
    private func configurePageControll() {
        pageControl.numberOfPages = slides.count
    }
    
    private func updateNextButtonTitle() {
        if currentPage == slides.count - 1 {
            nextButton.setTitle("Get started!", for: .normal)
        } else {
            nextButton.setTitle("Next", for: .normal)
        }
    }

}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as? OnboardingCollectionViewCell else {
            return UICollectionViewCell()
        }
        let slideInfo = slides[indexPath.item]
        cell.setup(slideInfo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
