import UIKit

extension Bundle {
	func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
		guard let url = url(forResource: file, withExtension: "json") else {
			fatalError("Failed to locate \(file) in bundle.")
		}

		guard let data = try? Data(contentsOf: url) else {
			fatalError("Failed to load \(file) from bundle.")
		}

		let decoder = JSONDecoder()

		do {
			return try decoder.decode(T.self, from: data)
		} catch {
			fatalError("Failed to decode \(file) from bundle. error: \(error.localizedDescription)")
		}
	}
}
