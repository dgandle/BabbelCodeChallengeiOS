//
//  WordsButton.swift
//  BabbelCodeChallengeiOS
//
//  Created by Doug Gandle on 11/17/22.
//

import SwiftUI

struct WordsButton: ButtonStyle {
	enum Style {
		case correct
		case wrong

		var color: Color {
			switch self {
			case .correct:
				return Color("correct")
			case .wrong:
				return Color("wrong")
			}
		}
	}

	var style: Style

	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.font(.system(size: 18, weight: .semibold))
			.frame(maxWidth: .infinity)
			.padding()
			.foregroundColor(Color.white)
			.background(configuration.isPressed ? style.color.opacity(0.6) : style.color)
			.cornerRadius(8)
			.animation(.easeOut(duration: 0.1), value: configuration.isPressed)
	}
}
