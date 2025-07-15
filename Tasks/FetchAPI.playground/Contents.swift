import UIKit

/// https://jsonplaceholder.typicode.com/users

struct User: Codable {
    let id: Int
    let name: String
    let email: String
}

import Foundation

func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
    let urlString = "https://jsonplaceholder.typicode.com/users"
    guard let url = URL(string: urlString) else {
        completion(.failure(URLError(.badURL)))
        return
    }

    URLSession.shared.dataTask(with: url) { data, response, error in
        // Handle error
        if let error = error {
            completion(.failure(error))
            return
        }

        // Handle response/data
        guard let data = data else {
            completion(.failure(URLError(.badServerResponse)))
            return
        }

        do {
            let users = try JSONDecoder().decode([User].self, from: data)
            completion(.success(users))
        } catch {
            completion(.failure(error))
        }
    }.resume()
}

/* Example */

fetchUsers { result in
    switch result {
    case .success(let users):
        for user in users {
            print("👤 \(user.name) - 📧 \(user.email)") // for UI update we will use DispatchQueue.main.async
        }
    case .failure(let error):
        print("Error fetching users: \(error.localizedDescription)")
    }
}

/// The same task by using async/await syntax


import Foundation

struct UserA: Codable {
    let id: Int
    let name: String
    let email: String
}

func fetchUsersA() async throws -> [UserA] {
    let url = URL(string: "https://jsonplaceholder.typicode.com/users")!

    let (data, _) = try await URLSession.shared.data(from: url)

    let users = try JSONDecoder().decode([UserA].self, from: data)
    return users
}

Task {
    do {
        let users = try await fetchUsersA()
        print("First user: \(users.first?.name ?? "None")")
    } catch {
        print("Failed to fetch: \(error.localizedDescription)")
    }
}


/// Serial of data fetching
let serialQueue = DispatchQueue(label: "com.example.serialFetchQueue")

func fetchItem(id: Int, completion: @escaping (String) -> Void) {
    DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
        completion("✅ Fetched item \(id)")
    }
}

func fetchItemsSeriallyWithQueue() {
    let ids = [1, 2, 3, 4, 5]

    for id in ids {
        serialQueue.async {
            let semaphore = DispatchSemaphore(value: 0)
            fetchItem(id: id) { result in
                print(result)
                semaphore.signal()
            }
            semaphore.wait() // Wait before starting next
        }
    }
}

