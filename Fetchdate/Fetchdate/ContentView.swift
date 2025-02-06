//
//  ContentView.swift
//  Fetchdate
//
//  Created by Sirarpi Bayramyan on 06.02.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PostsViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.postsWithAuthors, id: \ .0.id) { post, author in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(author)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Posts")
        }
    }
}

#Preview {
    ContentView()
}
