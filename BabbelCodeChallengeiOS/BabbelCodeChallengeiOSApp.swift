//
//  BabbelCodeChallengeiOSApp.swift
//  BabbelCodeChallengeiOS
//
//  Created by Doug Gandle on 11/17/22.
//

import SwiftUI

@main
struct BabbelCodeChallengeiOSApp: App {
    var body: some Scene {
		let repository = WordsRepository()
		let viewModel = WordsViewModel(repository: repository)

        WindowGroup {
            WordsView(viewModel: viewModel)
        }
    }
}
