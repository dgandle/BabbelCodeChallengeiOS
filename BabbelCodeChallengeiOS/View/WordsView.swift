//
//  ContentView.swift
//  BabbelCodeChallengeiOS
//
//  Created by Doug Gandle on 11/17/22.
//

import SwiftUI

struct WordsView: View {
	@ObservedObject var viewModel: WordsViewModel

    var body: some View {
		VStack {
			HStack {
				Spacer()
				VStack {
					Text("Correct Attempts: \(viewModel.correctAttempts)")
					Text("Wrong Attempts: \(viewModel.incorrectAttempts)")
				}
				.font(.caption)
			}
			Spacer()
			Text(viewModel.currentWordPair.wordPair.spanishText)
				.font(.system(size: 24, weight: .semibold))
				.padding()
			Text(viewModel.currentWordPair.wordPair.englishText)
				.padding()
			Spacer()
			HStack(spacing: 16) {
				Button("Correct") {
					viewModel.submit(selection: true)
				}
				.frame(maxWidth: .infinity)
				.padding()
				.overlay(
					RoundedRectangle(cornerRadius: 8)
						.stroke(Color.accentColor, lineWidth: 2)
				)
				Button("Wrong") {
					viewModel.submit(selection: false)
				}
				.frame(maxWidth: .infinity)
				.padding()
				.overlay(
					RoundedRectangle(cornerRadius: 8)
						.stroke(Color.accentColor, lineWidth: 2)
				)
			}
		}
		.padding()
		.onAppear {
			viewModel.loadWords()
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WordsView(viewModel: WordsViewModel(repository: WordsRepository()))
    }
}
