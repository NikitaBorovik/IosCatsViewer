//
//  CatImageView.swift
//  CatsViewer
//
//  Created by Никита Боровик on 21.05.2023.
//

import SwiftUI
import FirebasePerformance
import FirebaseCrashlytics

struct PetImageView: View {
    var imageUrl: String

    //some test comment
    var body: some View {
        let trace = Performance.startTrace(name: "TIME_TO_LOAD_IMAGE")
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onAppear{
                        trace?.stop()
                        Crashlytics.crashlytics().setCustomValue(imageUrl, forKey: "last_loaded_url")
                        Crashlytics.crashlytics().log("Loaded image with URL \(imageUrl)")
                    }
            case .failure(let error):
                Text("Failed to load image: \(error.localizedDescription)")
                    .onAppear{
                        trace?.stop()
                    }
            default:
                EmptyView()
            }
        }
         .frame(width: UIScreen.main.bounds.size.width, height: 350)
    }
}
struct CatImageView_Previews: PreviewProvider {
    static var previews: some View {
        PetImageView(imageUrl: "")
    }
}

