//
//  TestRepository.swift
//  BabbelCodeChallengeiOSTests
//
//  Created by Doug Gandle on 11/17/22.
//

import Foundation
import Combine
@testable import BabbelCodeChallengeiOS

class TestRepository: WordsRepositoryProtocol {
	func wordlist() -> AnyPublisher<[WordPair], WordsError> {
		let wordlist = [
			WordPair(englishText: "primary school", spanishText: "escuela primaria"),
			WordPair(englishText: "teacher", spanishText: "profesor / profesora"),
			WordPair(englishText: "pupil", spanishText: "alumno / alumna"),
			WordPair(englishText: "holidays", spanishText: "vacaciones ")
		]

		return Just(wordlist)
			.setFailureType(to: WordsError.self)
			.eraseToAnyPublisher()
	}
}
