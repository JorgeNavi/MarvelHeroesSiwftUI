import SwiftUI

struct HeroesView: View {
    
    @Environment(HeroesViewModel.self) var viewModel
    @State private var searchText: String = ""
    
    //Columns configuration
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.state {
                case .loading:
                    ProgressView("Loading heroes...")
                        .padding()
                case .loaded:
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.heroesData) { hero in
                                NavigationLink(destination: HeroDetailView(viewModel: HeroDetailViewModel(hero: hero))) {
                                    HeroCardView(hero: hero)
                                }
                            }
                        }
                        .padding()
                    }
                case .error(let error):
                    Text("\(error)")
                        .foregroundColor(.red)
                        .padding()

                }
            }
            .navigationTitle("Marvel Heroes")
            .searchable(text:$searchText, prompt: "Search Heroes...")
            .onChange(of: searchText) { oldValue, newValue in
                if !newValue.isEmpty, newValue.count > 2 {
                    Task {
                        await viewModel.getHeroes(newSearch: newValue)
                    }
                } else {
                    Task {
                        await viewModel.getHeroes(newSearch: "")
                    }
                }
            }
            .onAppear {
                searchText = viewModel.filterUI
            }
        }
    }
}

#Preview {
    let viewModel = HeroesViewModel(useCaseHeroes: HeroesUseCaseMock())
    return HeroesView().environment(viewModel)
}
