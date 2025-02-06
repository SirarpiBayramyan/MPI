//
//  PostsViewModel.swift
//  Fetchdate
//
//  Created by Sirarpi Bayramyan on 06.02.25.
//

import Combine
import Foundation

class PostsViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var posts: [Post] = []

    @Published var postsWithAuthors: [(Post, String)] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchData()
    }


    private func fetchData() {
        let mainUrl = "https://jsonplaceholder.typicode.com"


        let postsPublisher = URLSession.shared.dataTaskPublisher(for: URL(string: mainUrl+"/posts")!)
            .map { $0.data }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()

        let usersPublisher = URLSession.shared.dataTaskPublisher(for: URL(string: mainUrl+"/users")!)
            .map { $0.data }
            .decode(type: [User].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()

        Publishers.Zip(postsPublisher, usersPublisher)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] posts, users in
                guard let self = self else  { return }
                self.posts = posts
                self.users = users
                self.mapPostsToAuthors()
            })
            .store(in: &cancellables)

    }

    private func mapPostsToAuthors() {
        postsWithAuthors = posts.map { post in
            let author = users.first(where: { $0.id == post.userId })?.name ?? "Unknown"
            return (post, author)
        }
    }
}
