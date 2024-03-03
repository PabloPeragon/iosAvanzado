//
//  ApiProvider.swift
//  practicaIosAvanzado
//
//  Created by Pablo Jesús Peragón Garrido on 1/3/24.
//

import Foundation


enum GokuAndFriendsError: Error {
    case parsingData
}

enum GokuAndFriendsEndpoint {
    case login
    
    func urlWith(host: URL) -> URL {
        switch self {
        case .login:
            return host.appendingPathComponent("api/auth/login")
        }
    }
}

struct ResquestProvider {
    let host = URL(string: "https://dragonball.keepcoding.education")!
    
    func httpMethodFor(endpoint: GokuAndFriendsEndpoint) -> String {
        switch endpoint {
        case .login:
            return "POST"
        }
    }
    
    func resquesFor(endpoint: GokuAndFriendsEndpoint) -> URLRequest {
        switch endpoint {
        case .login:
            var request = URLRequest.init(url: endpoint.urlWith(host: host))
            request.httpMethod = self.httpMethodFor(endpoint: .login)
            return request
        }
    }
    
}

class ApiProvider {
    private var session: URLSession
    private var requestProvider: ResquestProvider
    private var secureData: SecureDataProtocol
    
    init(session: URLSession = URLSession.shared,
         requestProvider: ResquestProvider = ResquestProvider(),
         secureData: SecureDataProtocol = SecureDataKeychain()) {
        self.session = session
        self.requestProvider = requestProvider
        self.secureData = secureData
    }
    
    func loginWith(email: String, password: String, completion: @escaping(( Result<Bool, GokuAndFriendsError>) -> Void)) {
        var request = requestProvider.resquesFor(endpoint: .login)
        let credencials = String(format: "%@:%@", email, password)
        guard let data = credencials.data(using: .utf8)?.base64EncodedString() else {
            completion(.failure(.parsingData))
            return
        }
        request.setValue("Basic \(data)", forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request) { [weak self] data, response, error in
            //TODO: - Gestión de errores
            
            if let data {
                let token = String(data: data, encoding: .utf8)
                self?.secureData.setToken(value: token!)
                completion(.success(true))
            } else {
                //TODO: - Gestionar que no se reciba data
            }
        }.resume()
    }
        
}
