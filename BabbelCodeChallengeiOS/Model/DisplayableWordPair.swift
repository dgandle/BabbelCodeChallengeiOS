//
//  DisplayableWordPair.swift
//  BabbelCodeChallengeiOS
//
//  Created by Doug Gandle on 11/17/22.
//

import Foundation

struct DisplayableWordPair: Equatable {
	static var empty = DisplayableWordPair(wordPair: WordPair(englishText: "", spanishText: ""), correct: false)

	var wordPair: WordPair
	var correct: Bool
}
