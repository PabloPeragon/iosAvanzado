//
//  SplashViewModel.swift
//  practicaIosAvanzado
//
//  Created by Pablo Jesús Peragón Garrido on 28/2/24.
//

import Foundation

final class SplashViewModel {
   
    //indicarle que vista es
    var modelStatusLoad: ((SplashStatusLoad) -> Void)?
    
    //Funcion Simular Carga Datos
    func simulationLoadData() {
        modelStatusLoad?(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.modelStatusLoad?(.loaded)
        }
    }
}
