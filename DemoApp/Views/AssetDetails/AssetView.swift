//
//  AssetView.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 27.03.2024.
//

import SwiftUI
import GradientProgressBar

struct AssetView: View {
    let asset: Asset

    var body: some View {
        ZStack {
            URLImage(url: asset.image) {
                Image(Constants.Image.placeholderName)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
            }
            VStack(alignment: .leading) {
                lock
                    .opacity(asset.purchased ? 0 : 1)
                Spacer()
                progressBar
                    .frame(height: Constants.ProgressBar.height)
                    .opacity(asset.progress > 0 ? 1 : 0)
            }
        }
        .aspectRatio(2 / 3, contentMode: .fit)
        .clipShape(
            RoundedRectangle(cornerRadius: Constants.Image.cornerRadius)
        )
    }
}

extension AssetView {
    private var lock: some View {
        HStack {
            Image(Constants.Lock.imageName)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: Constants.Lock.size)
                .padding(Constants.Lock.padding)
            Spacer()
        }
    }
    
    private var progressBar: some View {
        GradientProgressView(value: Float(asset.progress),
                             total: Constants.ProgressBar.totalValue,
                             gradientColors: [.progressBarFirstGradient, .progressBarSecondGradient],
                             backgroundColor: .progressBarBackground)
    }
}

extension AssetView {
    private enum Constants {
        enum Image {
            static let width: CGFloat = 104
            static let height: CGFloat = 156
            static let cornerRadius: CGFloat = 12
            static let placeholderName: String = "imagePlaceholder"
        }
        
        enum Lock {
            static let imageName: String = "lock"
            static let size: CGFloat = 24
            static let padding: CGFloat = 8
        }
        
        enum ProgressBar {
            static let height: CGFloat = 4
            static let totalValue: Float = 100
        }
    }
}

struct AssetView_Previews: PreviewProvider {
    static let asset = Asset(id: "63f54792e03f635d5d84d9bf",
                             name: "reprehenderit eiusmod in",
                             image: URL(string: "https://picsum.photos/id/861/400/6000")!,
                             company: "Nixelt",
                             progress: 60,
                             purchased: false,
                             updatedAt: "2011-12-10T22:13:05.298Z",
                             releaseDate: "1990-04-20")
    static var previews: some View {
        AssetView(asset: asset)
            .frame(width: 104, height: 156)
    }
}
