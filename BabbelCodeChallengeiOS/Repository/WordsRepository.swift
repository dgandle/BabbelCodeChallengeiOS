//
//  WordsRepository.swift
//  BabbelCodeChallengeiOS
//
//  Created by Doug Gandle on 11/17/22.
//

import Foundation
import Combine
import UIKit

protocol WordsRepositoryProtocol {
	func wordlist() -> AnyPublisher<[WordPair], WordsError>
}

class WordsRepository {

	private let decoder = JSONDecoder()

	private func decode(_ data: Data) -> AnyPublisher<[WordPair], Error> {
		return Just(data)
			.decode(type: [WordPair].self, decoder: decoder)
			.eraseToAnyPublisher()
	}
}

extension WordsRepository: WordsRepositoryProtocol {
	func wordlist() -> AnyPublisher<[WordPair], WordsError> {
		if
			let path = Bundle.main.path(forResource: "words", ofType: "json"),
			let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
		{
			return decode(data)
				.mapError { error in
					WordsError.parsing(description: error.localizedDescription)
				}
				.eraseToAnyPublisher()
		} else {
			return Fail(error: WordsError.parsing(description: "Couldn't load file"))
				.eraseToAnyPublisher()
		}
	}
}
