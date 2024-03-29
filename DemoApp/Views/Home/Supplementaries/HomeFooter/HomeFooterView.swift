//
//  HomeFooterView.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 28.03.2024.
//

import Combine
import UIKit

final class HomeFooterView: UICollectionReusableView {
    static let viewKind = HomeSupplementaryViewKind.footer.rawValue
    private let pageControl = UIPageControl()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPageControl()
        setupPageControlConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with pageProvider: PromotionPageProvider) {
        subscribeOnCurrentPage(pageProvider)
        subscribeOnTotalPages(pageProvider)
    }
}

extension HomeFooterView {
    //MARK: subscribing
    private func subscribeOnCurrentPage(_ pageProvider: PromotionPageProvider) {
        let token = pageProvider.currentPagePublisher
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] page in
                self?.pageControl.currentPage = page
            }
        pageProvider.save(subscription: token)
    }
    
    private func subscribeOnTotalPages(_ pageProvider: PromotionPageProvider) {
        let token = pageProvider.totalPagesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] total in
                self?.pageControl.numberOfPages = total
            }
        pageProvider.save(subscription: token)
    }
    
    //MARK: pageControll
    private func setupPageControl() {
        addSubview(pageControl)
        
        pageControl.pageIndicatorTintColor = .semiOpaquePageIndicator
        pageControl.currentPageIndicatorTintColor = .pageIndicator
        pageControl.layer.cornerRadius = Constants.pageControlCornerRadius
        pageControl.isUserInteractionEnabled = false
        pageControl.subviews.forEach { indicator in
            indicator.transform = CGAffineTransform(
                scaleX: Constants.pageIndicatorScale,
                y: Constants.pageIndicatorScale
            )
        }
        setupPageControlShadow()
    }
    
    private func setupPageControlShadow() {
        pageControl.layer.shadowColor = UIColor.black.cgColor
        pageControl.layer.shadowOffset = CGSize(width: 0, height: 0)
        pageControl.layer.shadowOpacity = 1
        pageControl.layer.shadowRadius = Constants.pageControlCornerRadius
        pageControl.layer.masksToBounds = false
    }

    private func setupPageControlConstraints() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.centerYAnchor.constraint(equalTo: centerYAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: Constants.pageControlHeight),
            pageControl.widthAnchor.constraint(equalToConstant: Constants.pageControlWidth),
        ])
    }
}

extension HomeFooterView {
    private enum Constants {
        static let pageControlHeight: CGFloat = 15
        static let pageControlWidth: CGFloat = 155
        static let pageControlCornerRadius: CGFloat = 10
        static let pageIndicatorScale: CGFloat = 0.9
    }
}
