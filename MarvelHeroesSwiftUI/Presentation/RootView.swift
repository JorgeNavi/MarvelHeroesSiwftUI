import SwiftUI

struct RootView: View {
    @Environment(HeroesViewModel.self) var viewModel

    var body: some View {
        if viewModel.state == .loading {
            ProgressView("Loading heroes...")
        } else {
            HeroesView()
        }
    }
}


#Preview {
    let viewModel = HeroesViewModel(useCaseHeroes: HeroesUseCaseMock())
    return RootView().environment(viewModel)
}

