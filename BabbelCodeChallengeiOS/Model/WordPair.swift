//
//  WordPair.swift
//  BabbelCodeChallengeiOS
//
//  Created by Doug Gandle on 11/17/22.
//

import Foundation

struct WordPair: Decodable, Equatable {
	var englishText: String
	var spanishText: String

	enum CodingKeys: String, CodingKey {
		case englishText = "text_eng"
		case spanishText = "text_spa"
	}
}
