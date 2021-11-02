//
//  PaletteService.swift
//  SwiftPalette
//
//  Created by Leonardo D'Amato on 2021-10-23.
//

import Foundation

struct PaletteService {
    enum PaletteError: Error {
        case dataError
        case requestError
    }
    
    typealias getPaletteCompletion = (Result<[Palette], PaletteError>) -> Void
    
    
    static func getRandomPalette(completion: @escaping getPaletteCompletion) {
        
        let url = API.createRandomPaletteURL()
        
        let session = URLSession(configuration: .default, delegate: .none, delegateQueue: .main)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.requestError))
            }
            
            if let data = data {
                do {
                    let palette = try JSONDecoder().decode([Palette].self, from: data)
                    completion(.success(palette))
                    
                } catch {
                    print(error)
                    completion(.failure(.dataError))
                }
            }
        }
        
        task.resume()
    }
    
    static func getPalette(id: Int, completion: @escaping getPaletteCompletion) {
        
        let url = API.createPaletteURL(for: id)
        
        let session = URLSession(configuration: .default, delegate: .none, delegateQueue: .main)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.requestError))
            }
            
            if let data = data {
                do {
                    let palette = try JSONDecoder().decode([Palette].self, from: data)
                    completion(.success(palette))
                    
                } catch {
                    print(error)
                    completion(.failure(.dataError))
                }
            }
        }
        
        task.resume()
    }
}
