//
//  ModelData.swift
//  CatsViewer
//
//  Created by Никита Боровик on 21.05.2023.
//

import Foundation
import Networking
import FirebaseCrashlytics

class ModelData: ObservableObject{
    
    @Published var catsList:[PetData] = []
    
    var numberOfApiCalls = 0
    
    private let processor : ApiProcessor
    
    private let loadDogs: Bool
    
    init(loadDogs: Bool){
        self.loadDogs = loadDogs
        processor = ApiProcessor()
        loadPets()
    }
    
    func loadPets(){
        Task {
            numberOfApiCalls += 1
            Crashlytics.crashlytics().setCustomValue(numberOfApiCalls,forKey: "number_of_api_calls")

            
            let cats = await processor.getPets(loadDogs: loadDogs)

            DispatchQueue.main.async {
                self.catsList.append(contentsOf: cats)
            }
        }
    }
}

