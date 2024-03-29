//
//  HomeViewSkeleton.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 29.03.2024.
//

import SwiftUI

struct HomeViewSkeleton: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack() {
                    promotion
                        .padding(.horizontal, Constants.horizontalPadding)
                        .padding(.bottom, Constants.Promotion.bottomPadding)
                    VStack() {
                        header
                            .padding(.bottom, Constants.Headers.bottomPadding)
                        categories
                        header
                            .padding(.top, Constants.Headers.topPadding)
                            .padding(.bottom, Constants.Headers.bottomPadding)
                        movies
                        header
                            .padding(.top, Constants.Headers.topPadding)
                            .padding(.bottom, Constants.Headers.bottomPadding)
                        liveChannels
                        header
                            .padding(.top, Constants.Headers.topPadding)
                    }
                    .padding(.leading, Constants.horizontalPadding)
                    
                    
                }
            }.disabled(true)
        }
    }
}

extension HomeViewSkeleton {
    private var promotion: some View {
        Skeleton()
            .frame(height: Constants.Promotion.height)
            .cornerRadius(Constants.Promotion.cornerRadius)
    }
    
    private var categories: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(1...5, id: \.self) { _ in
                    VStack {
                        Skeleton()
                            .frame(width: Constants.Categories.size,
                                   height: Constants.Categories.size)
                            .cornerRadius(Constants.Categories.cornerRadius)
                        assetName
                    }
                }
            }
        }.disabled(true)
    }
    
    private var header: some View {
        HStack {
            Skeleton()
                .frame(width: Constants.Headers.width, height: Constants.Headers.height)
                .cornerRadius(Constants.Headers.cornerRadius)
            Spacer()
        }
    }
    
    private var movies: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(1...5, id: \.self) { _ in
                    VStack {
                        Skeleton()
                            .frame(width: Constants.Movies.width,
                                   height: Constants.Movies.height)
                            .cornerRadius(Constants.Movies.cornerRadius)
                        assetName
                    }
                }
            }
        }.disabled(true)
    }
    
    private var assetName: some View {
        Skeleton()
            .frame(width: Constants.AssetName.width, height: Constants.AssetName.height)
            .cornerRadius(Constants.AssetName.cornerRadius)
    }
    
    private var liveChannels: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(1...5, id: \.self) { _ in
                    Skeleton()
                        .frame(width: Constants.liveChannelSize,
                               height: Constants.liveChannelSize)
                        .clipShape(Circle())
                }
            }
        }.disabled(true)
    }
}

extension HomeViewSkeleton {
    private enum Constants {
        static let horizontalPadding: CGFloat = 24
        static let liveChannelSize: CGFloat = 104
        
        enum Promotion {
            static let height: CGFloat = 180
            static let cornerRadius: CGFloat = 16
            static let bottomPadding: CGFloat = 10
        }
        
        enum Categories {
            static let size: CGFloat = 104
            static let cornerRadius: CGFloat = 12
        }
        
        enum Headers {
            static let topPadding: CGFloat = 32
            static let bottomPadding: CGFloat = 6
            static let height: CGFloat = 24
            static let cornerRadius: CGFloat = 8
            static var width: CGFloat {
                let randomWidth = (100...200).randomElement()!
                return CGFloat(randomWidth)
            }
        }
        
        enum Movies {
            static let height: CGFloat = 156
            static let width: CGFloat = 104
            static let cornerRadius: CGFloat = 12
        }
        
        enum AssetName {
            static let height: CGFloat = 16
            static let cornerRadius: CGFloat = 6
            static var width: CGFloat {
                let randomWidth = (50...100).randomElement()!
                return CGFloat(randomWidth)
            }
        }
    }
}

struct HomeViewSkeleton_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewSkeleton()
    }
}
