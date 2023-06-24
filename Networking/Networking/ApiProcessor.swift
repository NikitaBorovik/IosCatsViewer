//
//  ApiProcessor.swift
//  Networking
//
//  Created by Никита Боровик on 21.05.2023.
//

import Foundation
import FirebasePerformance

public class ApiProcessor{
    
    public init(){}
    
    public func getPets(loadDogs: Bool) async -> [PetData]{
        let trace = Performance.startTrace(name: "TIME_TO_GET_DATA_FROM_API")
        let urlString: String
        if loadDogs{
            urlString = "https://api.thedogapi.com/v1/images/search?limit=10"
        }else{
            urlString = "https://api.thecatapi.com/v1/images/search?limit=10"
        }
        guard let url = URL(string: urlString)
        else{
            return []
        }
        do{
            let session = URLSession(configuration: .default)
            let (data, _) = try await session.data(from: url)
            let decoded = try JSONDecoder().decode([PetData].self, from: data)
            trace?.stop()
            return decoded
        }catch{
            trace?.stop()
            return[]
        }
        
    }
}
