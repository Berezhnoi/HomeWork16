//
//  OnboardingViewController.swift
//  HomeWork
//
//  Created by rendi on 17.04.2024.
//

import UIKit

class OnboardingViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var pageControl: UIPageControl!
    
    private let onboardingSteps: [OnboardingStep] = [
         OnboardingStep(title: "Step 1 Title", description: "Step 1 Description"),
         OnboardingStep(title: "Step 2 Title", description: "Step 2 Description"),
         OnboardingStep(title: "Step 3 Title", description: "Step 3 Description"),
         OnboardingStep(title: "Step 4 Title", description: "Step 4 Description"),
         OnboardingStep(title: "Step 5 Title", description: "Step 5 Description")
     ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray

        createUICollectionView()
        createUIPageControl()
        setupConstraints()
    }
}

private extension OnboardingViewController {
    private func createUICollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        
        view.addSubview(collectionView)
    }
    
    private func createUIPageControl() {
        pageControl = UIPageControl()
        pageControl.numberOfPages = onboardingSteps.count
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.addTarget(self, action: #selector(pageControlValueChanged(_:)), for: .valueChanged)
        view.addSubview(pageControl)
    }
    
    private func setupConstraints() {
        // Add constraints for pageControl
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        // Add constraint for collectionView
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor)
        ])
    }
    
    @objc private func pageControlValueChanged(_ sender: UIPageControl) {
        let currentPage = sender.currentPage
        let offsetX = CGFloat(currentPage) * collectionView.bounds.width
        let contentOffset = CGPoint(x: offsetX, y: collectionView.bounds.minY)
        collectionView.setContentOffset(contentOffset, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingSteps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as? OnboardingCollectionViewCell
        else {
            assertionFailure()
            return UICollectionViewCell()
        }
        
        let step = onboardingSteps[indexPath.item]
        cell.titleLabel.text = step.title
        cell.descriptionLabel.text = step.description
        cell.stepNumberLabel.text = "Step \(indexPath.item + 1)"
        
        // Show the action button only for the last cell
        if indexPath.item == onboardingSteps.count - 1 {
            cell.actionButton.isHidden = false
            cell.actionButtonHandler = {
                self.navigationController?.setViewControllers([MainViewController()], animated: true)
            }
        } else {
            cell.actionButton.isHidden = true
            cell.actionButtonHandler = nil
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension OnboardingViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
