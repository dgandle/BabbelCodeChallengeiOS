//
//  ContentView.swift
//  BabbelCodeChallengeiOS
//
//  Created by Doug Gandle on 11/17/22.
//

import SwiftUI

struct WordsView: View {
	@StateObject var viewModel: WordsViewModel

    var body: some View {
		VStack {
			HStack {
				Spacer()
				VStack(alignment: .trailing) {
					Text("Correct Attempts: \(viewModel.correctAttempts)")
					Text("Wrong Attempts: \(viewModel.incorrectAttempts)")
				}
				.font(.system(size: 14, weight: .regular))
			}
			Spacer()
			Text(viewModel.currentWordPair.wordPair.spanishText)
				.font(.system(size: 24, weight: .semibold))
				.padding()
			Text(viewModel.currentWordPair.wordPair.englishText)
				.font(.system(size: 18, weight: .regular))
				.padding()
			Spacer()
			HStack(spacing: 16) {
				Button("Correct") {
					viewModel.submit(selection: true)
				}
				.buttonStyle(WordsButton(style: .correct))
				Button("Wrong") {
					viewModel.submit(selection: false)
				}
				.buttonStyle(WordsButton(style: .wrong))
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
