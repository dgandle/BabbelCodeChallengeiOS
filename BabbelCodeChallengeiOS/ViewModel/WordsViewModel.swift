//
//  WordsViewModel.swift
//  BabbelCodeChallengeiOS
//
//  Created by Doug Gandle on 11/17/22.
//

import SwiftUI
import Combine

protocol WordsViewModelProtocol {
	func loadWords()
	func submit(correct: Bool)
}

class WordsViewModel: ObservableObject {
	@Published var currentWordPair: DisplayableWordPair = DisplayableWordPair.empty
	@Published var error: WordsError?
	@Published var correctAttempts: Int = 0
	@Published var incorrectAttempts: Int = 0

	private let repository: WordsRepositoryProtocol

	private var wordlist: [WordPair] = []
	private var disposables = Set<AnyCancellable>()

	private var timer: Timer? = nil {
		willSet {
			timer?.invalidate()
		}
	}

	init(repository: WordsRepositoryProtocol) {
		self.repository = repository
		self.loadWords()
	}

	func loadWords() {
		self.repository.wordlist()
			.sink { completion in
				switch completion {
				case .failure(let error):
					self.error = error
				case .finished:
					break
				}
			} receiveValue: { wordlist in
				self.wordlist = wordlist
				self.displayNewWordpair()
			}
			.store(in: &disposables)
	}

	func submit(selection: Bool) {
		if selection == self.currentWordPair.correct {
			self.correctAttempts += 1
		} else {
			self.incorrectAttempts += 1
		}

		self.displayNewWordpair()
	}
}

extension WordsViewModel {
	private func resetTimer() {
		timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
			self.incorrectAttempts += 1
			self.displayNewWordpair()
		}
	}

	private func displayNewWordpair() {
		self.checkEndCondition()

		let isCorrect = Int.random(in: 1...4) == 1

		if isCorrect {
			currentWordPair = getRandomCorrectPair(from: wordlist, previousPair: currentWordPair) ?? DisplayableWordPair.empty
		} else {
			currentWordPair = getRandomIncorrectPair(from: wordlist) ?? DisplayableWordPair.empty
		}

		self.resetTimer()
	}

	private func getRandomCorrectPair(from wordlist: [WordPair], previousPair: DisplayableWordPair?) -> DisplayableWordPair? {
		let newWordPair = wordlist.randomElement()

		guard newWordPair != previousPair?.wordPair else {
			return getRandomCorrectPair(from: wordlist, previousPair: previousPair)
		}

		if let newWordPair = newWordPair {
			return DisplayableWordPair(wordPair: newWordPair, correct: true)
		} else {
			return nil
		}
	}

	private func getRandomIncorrectPair(from wordlist: [WordPair]) -> DisplayableWordPair? {
		guard
			let firstWordPair = wordlist.randomElement(),
			let secondWordPair =  wordlist.randomElement()
		else {
			return nil
		}

		guard firstWordPair != secondWordPair else {
			return getRandomIncorrectPair(from: wordlist)
		}

		let newWordPair = WordPair(englishText: firstWordPair.englishText, spanishText: secondWordPair.spanishText)
		return DisplayableWordPair(wordPair: newWordPair, correct: false)
	}

	private func checkEndCondition() {
		if (incorrectAttempts == 3) || (correctAttempts + incorrectAttempts == 15) {
			exit(0)
		}
	}
}
