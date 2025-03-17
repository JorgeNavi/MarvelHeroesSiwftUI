import SwiftUI


//MARK: RootView
struct RootView: View {
    @Environment(HeroesViewModel.self) var viewModel

    var body: some View {
        
        switch viewModel.state {
        case .loading:
            ProgressView("Loading heroes...")
        case .loaded:
            HeroesView()
        case .error(let error):
            Text("Error: \(error)")
        }
        
    }
}


#Preview {
    let viewModel = HeroesViewModel(useCaseHeroes: HeroesUseCaseMock())
    return RootView().environment(viewModel)
}

