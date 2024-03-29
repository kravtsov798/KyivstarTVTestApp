//
//  HomeCollectionViewLayoutFactory.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 26.03.2024.
//

import UIKit

final class HomeCollectionViewLayoutFactory {
    static func createPromotionsSectionLayout() -> NSCollectionLayoutSection {
        let item = createItem(width: .fractionalWidth(1),
                              height: .fractionalWidth(1))
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(Constants.Sections.Promotion.height)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let footerYOffset = Constants.supplementaryHeight + Constants.Sections.Promotion.bottomContentInset
        let footer = createFooter(width: .fractionalWidth(1),
                                  height: .absolute(Constants.supplementaryHeight),
                                  offset: CGPoint(x: 0, y: -footerYOffset ))
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.contentInsets = .init(top: 0,
                                      leading: 0,
                                      bottom: Constants.Sections.Promotion.bottomContentInset,
                                      trailing: 0)
        section.boundarySupplementaryItems = [footer]
        return section
    }
    
    static func createCategoriesSectionLayout() -> NSCollectionLayoutSection {
        let section = createSectionLayoutWithHeader(
            itemWidth: .absolute(Constants.Sections.Categories.width),
            itemHeight: .absolute(Constants.Sections.Categories.height),
            groupWidth: .absolute(Constants.Sections.Categories.width),
            groupHeight: .absolute(Constants.Sections.Categories.height)
        )
        return section
    }
    
    static func createMovieSeriesSectionLayout() -> NSCollectionLayoutSection {
        let section = createSectionLayoutWithHeader(
            itemWidth: .fractionalWidth(1),
            itemHeight: .fractionalHeight(1),
            groupWidth: .absolute(Constants.Sections.MovieSeries.width),
            groupHeight: .absolute(Constants.Sections.MovieSeries.height)
        )
        return section
    }
    
    static func createLiveChannelSectionLayout() -> NSCollectionLayoutSection {
        let section = createSectionLayoutWithHeader(
            itemWidth: .fractionalWidth(1),
            itemHeight: .fractionalHeight(1),
            groupWidth: .absolute(Constants.Sections.LiveChannel.width),
            groupHeight: .absolute(Constants.Sections.LiveChannel.height)
        )
        return section
    }
    
    static func createEPGSectionLayout() -> NSCollectionLayoutSection {
        let section = createSectionLayoutWithHeader(
            itemWidth: .fractionalWidth(1),
            itemHeight: .fractionalHeight(1),
            groupWidth: .absolute(Constants.Sections.EPG.width),
            groupHeight: .absolute(Constants.Sections.EPG.height)
        )
        return section
    }
}

extension HomeCollectionViewLayoutFactory {
    static private func createSectionLayoutWithHeader(
        itemWidth: NSCollectionLayoutDimension, itemHeight: NSCollectionLayoutDimension,
        groupWidth: NSCollectionLayoutDimension, groupHeight: NSCollectionLayoutDimension
    ) -> NSCollectionLayoutSection {
        let item = createItem(width: itemWidth, height: itemHeight,
                              horizontalInset: Constants.Sections.interItemSpacing)
        
        let group = createGroup(width: groupWidth, height: groupHeight, item: item)
        
        let header = createHeader(width: .fractionalWidth(1),
                                  height: .absolute(Constants.supplementaryHeight),
                                  offset: CGPoint(x: Constants.Sections.interItemSpacing,
                                                  y: -Constants.headerOffset))
        
        let section = createSection(with: group, header: header,
                                    horizontalInset: Constants.Sections.horizontalContentInset,
                                    bottomInset: Constants.Sections.bottomContentInset)
        return section
    }
    
    private static func createItem(width: NSCollectionLayoutDimension,
                            height: NSCollectionLayoutDimension,
                            horizontalInset: CGFloat = 0) -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: width, heightDimension: height
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: horizontalInset,
                                       bottom: 0, trailing: horizontalInset)
        return item
    }
    
    private static func createGroup(width: NSCollectionLayoutDimension,
                             height: NSCollectionLayoutDimension,
                             item: NSCollectionLayoutItem) -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(
            widthDimension: width, heightDimension: height
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        return group
    }
    
    private static func createSection(with group: NSCollectionLayoutGroup,
                                      header: NSCollectionLayoutBoundarySupplementaryItem,
                                      horizontalInset: CGFloat,
                                      bottomInset: CGFloat
    ) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0,
                                      leading: horizontalInset,
                                      bottom: bottomInset,
                                      trailing: horizontalInset)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private static func createHeader(width: NSCollectionLayoutDimension,
                              height: NSCollectionLayoutDimension,
                              offset: CGPoint = .zero) -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: width, heightDimension: height
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: HomeHeaderView.viewKind,
            alignment: .topLeading,
            absoluteOffset: offset
        )
        return header
    }
    
    private static func createFooter(width: NSCollectionLayoutDimension,
                                     height: NSCollectionLayoutDimension,
                                     offset: CGPoint = .zero) -> NSCollectionLayoutBoundarySupplementaryItem  {
        let footerSize = NSCollectionLayoutSize(
            widthDimension: width, heightDimension: height
        )
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: HomeFooterView.viewKind,
            alignment: .bottom,
            absoluteOffset: offset
        )
        return footer
    }
}

extension HomeCollectionViewLayoutFactory {
    private enum Constants {
        static let headerOffset: CGFloat = 8
        static let supplementaryHeight: CGFloat = 24
        
        enum Sections {
            static let interItemSpacing: CGFloat = 4.5
            static var bottomContentInset: CGFloat = 32
            static var horizontalContentInset: CGFloat {
                24 - interItemSpacing
            }
            
            enum Promotion {
                static let height: CGFloat = 180
                static let bottomContentInset: CGFloat = 16
            }
            
            enum MovieSeries {
                static let height: CGFloat = 200
                static var width: CGFloat {
                    104 + interItemSpacing * 2
                }
            }
            
            enum EPG {
                static let height: CGFloat = 168
                static var width: CGFloat {
                    216 + interItemSpacing * 2
                }
            }
            
            enum LiveChannel {
                static let height: CGFloat = 104
                static var width: CGFloat {
                    height + interItemSpacing * 2
                }
            }
            
            enum Categories {
                static let height: CGFloat = 128
                static var width: CGFloat {
                    104 + interItemSpacing * 2
                }
            }
        }
    }
}
