//
//  HeroModel.swift
//  practicaIosAvanzado
//
//  Created by Pablo Jesús Peragón Garrido on 29/2/24.
//

import Foundation

struct HeroModel: Decodable {
    let id: String
    let name: String
    let description: String
    let photo: String
    let favorite: Bool
}
