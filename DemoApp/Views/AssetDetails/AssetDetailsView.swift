//
//  AssetDetailsView.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 22.03.2024.
//

import SwiftUI

struct AssetDetailsView<ViewModel: AssetDetailsRepresentable>: View {
    @ObservedObject var viewModel: ViewModel
    @State private var showError = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing: 0) {
                image
                    .frame(height: Constants.imageHeight)
                    .padding(.bottom, Constants.unscrollableItemPadding)
                AssetInfoView<ViewModel>().environmentObject(viewModel)
                    .padding(.horizontal, 24)
            }
        }
        .onChange(of: viewModel.errorMessage, perform: { newValue in
            showError = newValue != nil
        })
        .alert(isPresented: $showError) {
            alert
        }
        .onAppear {
            Task {
                await viewModel.fetchAssetDetails()
            }
        }
    }
}

extension AssetDetailsView {
    private var alert: Alert {
        Alert(
            title: Text(Constants.Alert.titleText),
          message: Text(viewModel.errorMessage ?? ""),
            dismissButton: .default(Text(Constants.Alert.dismissButtonText)) {
              viewModel.dismissErrorTapped()
          })
    }
    
    //MARK: assetImage
    @ViewBuilder
    private var image: some View {
        if viewModel.showSkeleton { Skeleton() } else
        if viewModel.imageURL != nil {
            URLImage(url: viewModel.imageURL) {
                placeholder
            }
        } else {
            placeholder
        }
    }
    
    private var placeholder: some View {
        Image(Constants.placeholderName)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
    }
}

extension AssetDetailsView {
    private enum Constants {
        static var unscrollableItemPadding: CGFloat { 16 }
        static var imageHeight: CGFloat { 211 }
        static var placeholderName: String { "imagePlaceholder" }
        
        enum Alert {
            static var titleText: String { "Error!" }
            static var dismissButtonText: String { "OK!" }
        }
    }
}

struct AssetDetailsView_Previews: PreviewProvider {
    static var previews: some View {
            AssetDetailsView(viewModel: AssetDetailsViewModel(apiService: ApiService()))
    }
}


