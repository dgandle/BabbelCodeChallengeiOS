//
//  BabbelCodeChallengeiOSTests.swift
//  BabbelCodeChallengeiOSTests
//
//  Created by Doug Gandle on 11/17/22.
//

import XCTest
import Combine
@testable import BabbelCodeChallengeiOS

class BabbelCodeChallengeiOSTests: XCTestCase {

	private var disposables = Set<AnyCancellable>()

	func testWordsRepositoryDecodesJSON() {
		let repository = WordsRepository()

		repository.wordlist()
			.sink { completion in
				switch completion {
				case .finished:
					break
				case .failure(let error):
					XCTFail(error.localizedDescription)
				}
			} receiveValue: { wordpair in
				XCTAssertEqual(wordpair.first?.englishText, "primary school")
			}
			.store(in: &disposables)
	}

	func testWordsViewModelLoadWords() {
		let repository = TestRepository()
		let viewModel = WordsViewModel(repository: repository)

		viewModel.loadWords()

		XCTAssert(viewModel.currentWordPair != DisplayableWordPair.empty)
	}

	func testWordsViewModelSelection() {
		let repository = TestRepository()
		let viewModel = WordsViewModel(repository: repository)

		viewModel.loadWords()

		let isCurrentSelectionCorrect = viewModel.currentWordPair.correct

		viewModel.submit(selection: true)

		if isCurrentSelectionCorrect {
			XCTAssert(viewModel.correctAttempts == 1)
		} else {
			XCTAssert(viewModel.incorrectAttempts == 1)
		}
	}
}
