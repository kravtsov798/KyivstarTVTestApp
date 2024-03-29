//
//  AssetInformationView.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 29.03.2024.
//

import SwiftUI

struct AssetInfoView<ViewModel: AssetDetailsRepresentable>: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var showFullDescription = false
    
    var body: some View {
        VStack(spacing: 0) {
            buttons
                .padding(.bottom, Constants.unscrollableItemPadding)
                .opacity(viewModel.showSkeleton ? 0.5 : 1)
            Color.lightGray
                .frame(height: Constants.separatorHeight)
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    name
                    assetInfo
                    description
                        .padding(.bottom, 14)
                        .onTapGesture {
                            showFullDescription.toggle()
                        }
                    similar
                    assetsGrid
                }.padding(.top, 20)
            }
            .disabled(viewModel.showSkeleton)
        }
    }
}

extension AssetInfoView {
    //MARK: buttons
    private var buttons: some View {
        HStack {
            Button { viewModel.playButtonTapped() } label: { playButtonLabel }
                .buttonStyle(playButtonStyle)
                .disabled(viewModel.showSkeleton)
            Spacer()
            Button { viewModel.favoriteButtonTapped() } label: { favoriteButtonImage }
                .buttonStyle(favoriteButtonStyle)
                .disabled(viewModel.showSkeleton)
        }
        .font(.system(size: Constants.Buttons.fontSize, weight: .medium))
    }
    
    private var playButtonLabel: some View {
        Label(Constants.PlayButton.text, systemImage: Constants.PlayButton.imageName)
            .labelStyle(InterspacingLabelStyle(spacing: Constants.labelInterspacing))
            .foregroundColor(.white)
    }
    
    private var playButtonStyle: BorderedButtonStyle {
        BorderedButtonStyle(
            width: Constants.PlayButton.width,
            height: Constants.Buttons.height,
            color: .blueButton,
            borderColor: .blueButtonBorder,
            shadowColor: .blueButtonShadow,
            pressedColor: .blueButtonTapped
        )
    }
    
    private var favoriteButtonImage: some View {
        Image(systemName: Constants.FavoriteButton.imageName)
            .foregroundColor(viewModel.isFavorite ? .white : .darkGray)
            .scaleEffect(viewModel.isFavorite ? Constants.FavoriteButton.imageScale : 1)
            .rotationEffect(.degrees(
                viewModel.isFavorite ? Constants.FavoriteButton.imageRotationDegrees : 0
            ))
            .animation(viewModel.isFavorite
                       ? .spring(response: 0.2, dampingFraction: 0.3, blendDuration: 0)
                       : .linear(duration: 0.2))
    }
    
    private var favoriteButtonStyle: BorderedButtonStyle {
        BorderedButtonStyle(
            width: Constants.FavoriteButton.width,
            height: Constants.Buttons.height,
            color: viewModel.isFavorite ? .blueButton : .lightGray,
            borderColor: viewModel.isFavorite ? .blueButtonBorder : .lightGrayButtonBorder,
            shadowColor: viewModel.isFavorite ? .blueButtonShadow : .lightGrayButtonShadow
        )
    }
    
    //MARK: texts
    @ViewBuilder
    private var name: some View {
        if viewModel.showSkeleton { nameSkeleton } else {
            Text(viewModel.name)
                .font(.system(size: Constants.nameFontSize, weight: .bold))
                .foregroundColor(.assetNameTextBlack)
        }
    }
    
    @ViewBuilder
    private var description: some View {
        if viewModel.showSkeleton { descriptionSkeleton } else {
            let text = Text(viewModel.description)
                .font(.system(size: Constants.Description.fontSize))
                .foregroundColor(.assetDescriptionTextGray)
            
            if showFullDescription {
                text
            } else {
                text.frame(height : Constants.Description.halfExpandedHeight)
            }
        }
    }
    
    private var similar: some View {
        Text(Constants.Similar.text)
            .font(.system(size: Constants.Similar.fontSize, weight: .semibold))
            .foregroundColor(.sectionTitleBlack)
    }
    
    @ViewBuilder
    private var assetInfo: some View {
        if viewModel.showSkeleton { assetInfoSkeleton } else {
            if let info = viewModel.info {
                Text(info)
                    .foregroundColor(.darkGray)
                    .font(.system(size: Constants.assetInfoFontSize, weight: .medium))
            }
        }
    }
    
    //MARK: similarAssetsGrid
    @ViewBuilder
    private var assetsGrid: some View {
        if viewModel.showSkeleton { assetsGridSkeleton } else {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.similarAssets) { asset in
                    AssetView(asset: asset)
                }
            }
        }
    }
    
    private var columns: [GridItem] {
        [GridItem(.flexible()),
         GridItem(.flexible()),
         GridItem(.flexible())]
    }
    
    //MARK: skeletons
    private var nameSkeleton: some View {
        Skeleton()
            .frame(width: Constants.Skeletons.Name.width, height: Constants.Skeletons.Name.height)
            .cornerRadius(Constants.Skeletons.Name.cornerRadius)
    }
    
    private var descriptionSkeleton: some View {
        Skeleton()
            .frame(height: Constants.Skeletons.Description.height)
            .cornerRadius(Constants.Skeletons.Description.cornerRadius)
    }
    
    private var assetInfoSkeleton: some View {
        Skeleton()
            .frame(width: Constants.Skeletons.AssetInfo.width,
                   height: Constants.Skeletons.AssetInfo.height)
            .cornerRadius(Constants.Skeletons.AssetInfo.cornerRadius)
    }
    
    private var assetsGridSkeleton: some View {
        LazyVGrid(columns: columns) {
            ForEach(1...8, id: \.self) { asset in
                Skeleton()
                    .frame(width: Constants.Skeletons.AssetsGrid.width,
                           height: Constants.Skeletons.AssetsGrid.height)
                    .cornerRadius(Constants.Skeletons.AssetsGrid.cornerRadius)
            }
        }
    }
}

struct AssetInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AssetInfoView<AssetDetailsViewModel>()
    }
}
