import SwiftUI


//MARK: View of simple serie card
struct SerieCardView: View {
    
    let serie: SerieResult
    
    var body: some View {
        VStack(alignment: .leading) {
            //Image first
            AsyncImage(url: URL(string: "\(serie.thumbnail.path).\(serie.thumbnail.thumbnailExtension)")) { image in
                image.resizable()
                    .scaledToFill()
                //if image is missing or has not loaded:
            } placeholder: {
                ProgressView()
                    .id("serie_image_loading_\(serie.id)") //id for testting
            }
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .id("serie_image_\(serie.id)") //id for testting
            
            //Serie Title
            Text(serie.title)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top, 4)
                .id("serie_title_\(serie.id)")
            
            //Serie description if there is any
            Text(serie.description ?? "No description available.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .id("serie_description_\(serie.id)") //id for testting
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 4)
        .id("serie_card_\(serie.id)") //id for testting
    }
}

#Preview {
    let mockSerie = SerieResult(
        id: 1,
        title: "The Incredible Hulk",
        description: "Una de las series más icónicas de Marvel.",
        resourceURI: "http://gateway.marvel.com/v1/public/series/1",
        urls: [SerieURLElement(type: "detail", url: "http://marvel.com/comics/series/1")],
        startYear: 1962,
        endYear: 1999,
        rating: "PG",
        type: "ongoing",
        modified: Date(),
        thumbnail: SerieThumbnail(
            path: "https://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
            thumbnailExtension: "jpg"
        ),
        creators: SerieCreators(available: 5, collectionURI: "", items: [], returned: 5),
        characters: SerieCharacters(available: 10, collectionURI: "", items: [], returned: 10),
        stories: SerieStories(available: 15, collectionURI: "", items: [], returned: 15),
        comics: SerieCharacters(available: 20, collectionURI: "", items: [], returned: 20),
        events: SerieCharacters(available: 2, collectionURI: "", items: [], returned: 2),
        next: nil,
        previous: nil
    )

    SerieCardView(serie: mockSerie)
}
