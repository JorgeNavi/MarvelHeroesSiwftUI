import SwiftUI

struct HeroesView: View {
    
    @Environment(HeroesViewModel.self) var viewModel
    
    // Configuración de la cuadrícula
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search hero...", text: Binding(
                    get: { viewModel.filterUI },
                    set: { newValue in
                        viewModel.filterUI = newValue
                        
                        if !newValue.isEmpty, newValue.count > 2 {
                            Task { await viewModel.getHeroes(newSearch: newValue) }
                        } else {
                            Task { await viewModel.getHeroes(newSearch: "") }
                        }
                    }
                ))
                .padding()

                if viewModel.state == .loading {
                    ProgressView("Loading heroes...")
                        .padding()
                        .id("loading ProgressView") // 🔹 Esto permite que ViewInspector lo encuentre
                } else if case .error(let message) = viewModel.state {
                    Text("⚠️ \(message)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.heroesData) { hero in
                                NavigationLink(destination: HeroDetailView(viewModel: HeroDetailViewModel(hero: hero))) {
                                    HeroCardView(hero: hero)
                                }
                            }
                        }
                        .padding()
                        .id("loaded scrollview")
                    }
                }
            }
            .navigationTitle("Héroes")
        }
    }
}

#Preview {
    let viewModel = HeroesViewModel(useCaseHeroes: HeroesUseCaseMock())
    return HeroesView().environment(viewModel)
}
