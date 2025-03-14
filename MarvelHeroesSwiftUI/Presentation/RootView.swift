import SwiftUI

struct RootView: View {
    @Environment(HeroesViewModel.self) var viewModel

    var body: some View {
        if viewModel.state == .loading {
            ProgressView("Loading heroes...")
                .onAppear {
                    Task { await viewModel.getHeroes() }
                }
        } else {
            HeroesView()
        }
    }
}

// MARK: - Vista Previa
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HeroesViewModel()
        return RootView().environment(viewModel)
    }
}

