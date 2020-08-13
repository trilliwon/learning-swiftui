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
}

struct Book: Codable {
	let title: String
	let authors: [String]
	let contents: String
	let datetime: String
	let isbn: String
	let price: Int
	let sale_price: Int?
	let thumbnail: String
	let status: String
	let translators: [String]
	let url: String
	let publisher: String
}

extension Book {
	var formattedPrice: String? {
		NumberFormatter.priceFormatter.locale = Locale(identifier: "ko_KR")
		return NumberFormatter.priceFormatter.string(from: NSNumber(value: price))
	}

	var formattedSalePrice: String? {
		NumberFormatter.priceFormatter.locale = Locale(identifier: "ko_KR")
        guard let salePrice = sale_price else { return nil }
		return NumberFormatter.priceFormatter.string(from: NSNumber(value: salePrice))
	}
}


let books = Bundle.main.decode([Book].self, from: "books.json")

let sampleBook: Book = books[0]
