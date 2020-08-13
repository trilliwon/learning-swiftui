//
//  Book.swift
//  bookstand
//
//  Created by Won on 2019/09/27.
//  Copyright © 2019 Won. All rights reserved.
//

import Foundation

struct Documents: Codable {
    var documents: [Book]
    var meta: Meta

    struct Meta: Codable {
        var is_end: Bool?
        var pageable_count: Int?
        var totoal_count: Int?
    }
}

struct Book: Codable, Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let authors: [String]
    let contents: String
    let datetime: String
    let isbn: String
    let price: Int
    let salePrice: Int?
    let thumbnail: String
    let status: String
    let translators: [String]
    let url: String
    let publisher: String

    enum CodingKeys: String, CodingKey {
        case title
        case authors
        case contents
        case datetime
        case isbn
        case price
        case salePrice = "sale_price"
        case thumbnail
        case status
        case translators
        case url
        case publisher
    }
}

extension Book: Equatable {
    static func == (rhs: Book, lhs: Book) -> Bool {
        rhs.id == lhs.id
    }
}

extension Book {
    var formattedPrice: String? {
        NumberFormatter.priceFormatter.locale = Locale(identifier: "ko_KR")
        return NumberFormatter.priceFormatter.string(from: NSNumber(value: price))
    }
    
    var formattedSalePrice: String? {
        NumberFormatter.priceFormatter.locale = Locale(identifier: "ko_KR")
        guard let salePrice = salePrice else { return nil }
        return NumberFormatter.priceFormatter.string(from: NSNumber(value: salePrice))
    }
}


let books = Bundle.main.decode([Book].self, from: "books.json")

let sampleBook: Book = books[0]
