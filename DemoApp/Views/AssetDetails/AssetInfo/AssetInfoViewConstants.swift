//
//  AssetDetailsViewConstants.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 29.03.2024.
//

import Foundation

extension AssetInfoView {
    enum Constants {
        static var assetInfoFontSize: CGFloat { 14 }
        static var separatorHeight: CGFloat { 1 }
        static var unscrollableItemPadding: CGFloat { 16 }
        static var labelInterspacing: CGFloat { 15 }
        
        static var nameFontSize: CGFloat { 22 }
        
        enum Similar {
            static var text: String { "Similar" }
            static var fontSize: CGFloat { 16 }
        }
        
        enum Description {
            static var fontSize: CGFloat { 12 }
            static var halfExpandedHeight: CGFloat { 32 }
        }
        
        enum Buttons {
            static var height: CGFloat { 40 }
            static var fontSize: CGFloat { 16 }
        }
        
        enum PlayButton {
            static var width: CGFloat { 129 }
            static var text: String { "Play" }
            static var imageName: String { "play.fill" }
        }
        
        enum FavoriteButton {
            static var width: CGFloat { 66 }
            static var imageName: String { "star.fill" }
            static var imageRotationDegrees: Double { 360 / 5 }
            static var imageScale: CGFloat { 1.15 }
        }

        enum Skeletons {
            enum Name {
                static var width: CGFloat { 200 }
                static var height: CGFloat { 40 }
                static var cornerRadius: CGFloat { 12 }
            }
            
            enum Description {
                static var height: CGFloat { 50 }
                static var cornerRadius: CGFloat { 12 }
            }
            
            enum AssetInfo {
                static var width: CGFloat { 250 }
                static var height: CGFloat { 16 }
                static var cornerRadius: CGFloat { 5 }
            }
            
            enum AssetsGrid {
                static var width: CGFloat { 104 }
                static var height: CGFloat { 156 }
                static var cornerRadius: CGFloat { 12 }
            }
        }
    }
}
