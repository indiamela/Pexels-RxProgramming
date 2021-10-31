//
//  SearchView.swift
//  Pexels-RxProgramming
//
//  Created by TaishiKusunose on 2021/10/30.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: PexelsViewModel
    @State var text: String = ""
    
    init(viewModel: PexelsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView{
            if viewModel.loading {
                ActivityIndicator()
            } else {
                VStack{
                    searchBar
                    if viewModel.dataSource.isEmpty {
                        VStack{
                            Spacer()
                            Image(systemName: "magnifyingglass.circle.fill")
                                .font(.title)
                            Text("nothing results")
                            Spacer()
                        }
                    } else {
                        picturesList
                    }
                }
                .accentColor(.black)
                .padding()
            }
        }
    }
}

extension SearchView {
    var searchBar: some View {
        HStack(alignment:.center,spacing: 20) {
            TextField("search", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button {
                if text.count > 0 {
                    viewModel.fetchPictures(for: text)
                }
            } label: {
                Text("検索")
                    .fontWeight(.bold)
                    .frame(width: 80, height: 40, alignment: .center)
                    .background(Color.yellow)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
    var picturesList: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3)) {
                pictureContent
            }
        }
    }
    var pictureContent: some View {
        ForEach(viewModel.dataSource) { picture in
            if let data = picture.data {
                let img = UIImage(data: data)
                let name = picture.photographer
                NavigationLink {
                    DetailImageView(image: img!, name: name)
                } label: {
                    VStack{
                        Image(uiImage: img!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text(name)
                            .font(.caption)
                    }
                    .frame(height: 150)
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: PexelsViewModel(apiClient: PexelsAPIClient()))
    }
}

struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}
