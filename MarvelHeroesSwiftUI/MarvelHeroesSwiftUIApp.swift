

import SwiftUI

@main
struct MarvelHeroesSwiftUIApp: App {
    
    @State var viewModel = HeroesViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(viewModel)
        }
    }
}
