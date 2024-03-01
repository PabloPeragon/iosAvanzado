//
//  HomeUseCase.swift
//  practicaIosAvanzado
//
//  Created by Pablo Jesús Peragón Garrido on 29/2/24.
//

import Foundation

//MARK: PROTOCOLO HOME USE CASE
protocol HomeUseCaseProtocol {
    func getHeroes(onSuccess: @escaping ([HeroModel]) -> Void, onError: @escaping (NetworkError) -> Void)
}

//MARK: Clase homeUseCase que conforma el protocolo de arriba
final class HomeUseCase: HomeUseCaseProtocol {
    func getHeroes(onSuccess: @escaping ([HeroModel]) -> Void, onError: @escaping (NetworkError) -> Void) {
        
        //Comprobar URL
        guard let url = URL(string: "\(EndPoints.url.rawValue)\(EndPoints.allHeros.rawValue)") else {
            onError(.malformedURL)
            return
        }
        
        //Crear REQUEST
        //TODO: Obtener el token de algun lado
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethods.post
        urlRequest.setValue("Bearer", forHTTPHeaderField: "Authorization")
        urlRequest.setValue(HTTPMethods.contentType, forHTTPHeaderField: "Content-Type")
        
        //Body
        struct HeroRequest: Encodable {
            let name: String
        }
        
        let heroRequest = HeroRequest(name: "")
        urlRequest.httpBody = try? JSONEncoder().encode(heroRequest)
        
        //TASK
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            //Check error
            guard error == nil else {
                onError(.orther)
                return
            }
            
            //Check Data
            guard let data = data else {
                onError(.noData)
                return
            }
            
            //Check response
            guard let httpResponse = (response as? HTTPURLResponse),
                  httpResponse.statusCode == HTTPResponseCodes.SUCCESS else {
                onError(.errorCode((response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            guard let heroResponse = try? JSONDecoder().decode([HeroModel].self, from: data) else {
                onError(.decoding)
                return
            }
            
            onSuccess(heroResponse)
        }
        task.resume()
    }
    
}
