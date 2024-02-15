//
//  ContentView.swift
//  NetworkImageTest
//
//  Created by Yash Tak on 14/02/24.
//

import SwiftUI
import Kingfisher

struct ContentView: View {

    private let defaultImg = "music.note"

    private let imgURL = "https://i.scdn.co/image/ab67616d0000b2739933d951d1318d4a11d7766e"

    @State
    private var hasFailed = false

    var body: some View {

        ZStack {

            if(!hasFailed) {

                KFImage.url(URL(string: "\(imgURL)"), cacheKey: imgURL)
                    .placeholder({ progress in
                        ProgressView()
                            .progressViewStyle(.circular)
                    })
                    .onSuccess({ result in
                        print("Image Load Complete")
                        hasFailed = false
                    })
                    .onFailure({ error in
                        print("Failed To Load From URL")
                        print("Before -> \(hasFailed)")
                        hasFailed = true
                        print("After -> \(hasFailed)")
                    })
                    .fade(duration: 1.0)
                    .retry(maxCount: 1)
                    .cancelOnDisappear(true)
                    .cacheOriginalImage(true)
                    .waitForCache(true)
                    .fromMemoryCacheOrRefresh(true)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {

                Image(systemName: defaultImg)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(width: 100, height: 100)
        .overlay {
            RoundedRectangle(cornerRadius: 100/8)
                .stroke(.white, lineWidth: 2.0)
        }
    }
}

#Preview {

    ContentView()
        .preferredColorScheme(.dark)
}
