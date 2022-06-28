//
//  PhotosModel.swift
//  UnsplashPhoto
//
//  Created by Вячеслав Терентьев on 28.06.2022.
//

import Foundation

struct APIresponse: Decodable {
    let total: Int
    let total_pages: Int
    let results: [ResultPhoto]
}

struct ResultPhoto: Decodable {
    let id: String
    let urls: Urls
    let user: User
    let likes: Int
    let created_at: String

    
}

struct Urls: Decodable {
    let regular: String
}

struct User: Decodable {
    let id: String
    let name: String
    let location: String?

}
