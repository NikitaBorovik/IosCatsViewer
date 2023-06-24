//
//  ContentView.swift
//  CatsViewer
//
//  Created by Никита Боровик on 21.05.2023.
//

import SwiftUI
import Networking
import FirebaseCrashlytics

struct ContentView: View {
    @StateObject private var modelData : ModelData
    private var showDogs: Bool

    init(shouldShowDogs: Bool) {
        self.showDogs = shouldShowDogs
        _modelData = StateObject(wrappedValue: ModelData(loadDogs: shouldShowDogs))
    }

    var body: some View {
        VStack{
            NavigationView {
                ScrollView {
                    LazyVStack {
                        ForEach(modelData.catsList, id: \.url) { catData in
                            NavigationLink(destination: PetImageView(imageUrl: catData.url)) {
                                PetImageView(imageUrl: catData.url)
                            }
                        }
                        Color.clear
                            .frame(height: 1)
                            .onAppear(){
                                Crashlytics.crashlytics().log("Loading new data portion")
                                modelData.loadPets()
                                
                            }
                    }
                }
                .navigationTitle(showDogs ? "Dogs" : "Cats")
            }
            Button("Crash") {
              fatalError("Crash was triggered")
            }
            .foregroundColor(Color.primary)
            .frame(maxWidth: .infinity)
            .font(.title)
            .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.primary,lineWidth: 2))
            .padding()
        }
    }
    
    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView(shouldShowDogs: false)
        }
    }
}

