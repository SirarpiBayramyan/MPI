import Foundation

// Write a function that concurrently fetches two URLs and returns their data only when both are complete. Use Swift 5.5+ async/await.
func fetchBoth(url1: URL, url2: URL) async throws -> (Data, Data) {
    // Implement concurrency using async/await

    async let data1 = URLSession.shared.data(from: url1).0
    async let data2 = URLSession.shared.data(from: url2).0

    let result1 = try await data1
    let result2 = try await data2

    return (result1, result2)

}


let url1 = URL(string: "https://example.com/1")!
let url2 = URL(string: "https://example.com/2")!

Task {
    do {
        let (data1, data2) = try await fetchBoth(url1: url1, url2: url2)
        print("Fetched \(data1.count) bytes and \(data2.count) bytes")
    } catch {
        print("Error fetching data: \(error)")
    }
}


func fetchMultiple(urls: [URL]) async throws -> [Data] {
    try await withThrowingTaskGroup(of: Data.self) { group in
        var results: [Data] = []

        for url in urls {
            group.addTask {
                let (data, _) = try await URLSession.shared.data(from: url)
                return data
            }
        }

        for try await data in group {
            results.append(data)
        }

        return results
    }
}
