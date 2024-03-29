//
//  URLImage.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 28.03.2024.
//

import SwiftUI

struct URLImage<Placeholder: View>: View {
    private let url: URL?
    private var placeholder: Placeholder
    
    @State private var image: Image? = nil
    private var imageProvider = URLImageProvider()
    
    init(url: URL?, @ViewBuilder placeholder: () -> Placeholder) {
        self.url = url
        self.placeholder = placeholder()
    }
    
    var body: some View {
        if let image {
            image.resizable()
        } else {
            placeholder
                .onAppear {
                    fetchImage()
                }
        }
    }
    
    private func fetchImage() {
        Task { do {
            guard let url else { return }
            let uiImage = try await imageProvider.fetchImage(by: url)
            image = Image(uiImage: uiImage)
        } }
    }
}
