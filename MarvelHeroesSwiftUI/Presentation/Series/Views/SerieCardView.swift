import SwiftUI

struct SerieCardView: View {
    let serie: Serie
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: "\(serie.thumbnail.path).\(serie.thumbnail.thumbnailExtension)")) { image in
                image.resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text(serie.title)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top, 4)
            
            Text(serie.description ?? "No description available.")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 4)
    }
}

#Preview {
    let mockSerie = Serie(
        id: 1,
        title: "The Incredible Hulk",
        description: "Una de las series más icónicas de Marvel.",
        resourceURI: "http://gateway.marvel.com/v1/public/series/1",
        urls: [URLElement(type: "detail", url: "http://marvel.com/comics/series/1")],
        startYear: 1962,
        endYear: 1999,
        rating: "PG",
        type: "ongoing",
        modified: Date(),
        thumbnail: SerieThumbnail(
            path: "https://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
            thumbnailExtension: "jpg"
        ),
        creators: Characters(available: 5, collectionURI: "", items: [], returned: 5),
        characters: Characters(available: 10, collectionURI: "", items: [], returned: 10),
        stories: Characters(available: 15, collectionURI: "", items: [], returned: 15),
        comics: Characters(available: 20, collectionURI: "", items: [], returned: 20),
        events: Characters(available: 2, collectionURI: "", items: [], returned: 2),
        next: JSONNull(),
        previous: JSONNull()
    )
    
    return SerieCardView(serie: mockSerie)
}
