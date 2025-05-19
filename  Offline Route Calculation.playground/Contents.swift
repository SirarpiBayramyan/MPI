
import Foundation
import UIKit

struct User: Decodable {
    let id: UUID
}

struct Profile: Decodable {
    let imageUrl: String
}

func fetchUser() async throws  -> User {

}

func fetchProfile(userId: UUID) async throws  -> Profile {

}

func fetchImage(_ url: String) async throws  ->  UIImage {

}
func loadData() async throws -> Data {
    let user = try await fetchUser()
        let profile = try await fetchProfile(userId: user.id)
        let image = try await fetchImage(profile.imageUrl)

        guard let imageData = image.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 0, userInfo: nil)
        }

        return imageData
}

