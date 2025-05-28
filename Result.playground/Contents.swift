import Foundation

/// A generic, chainable result type that represents either a success (with associated value)
/// or a failure (with associated error).
///
/// `ResultChain` is similar to Swift's native `Result` type but adds additional chaining capabilities
/// inspired by Promises/Futures. It supports operations like `map`, `flatMap`, and error recovery.
///
/// - Success: The type of value associated with a successful result.
/// - Failure: The type of error associated with a failure result (must conform to Error).
enum ResultChain<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)

    // MARK: - Map transforms the value if it's a success
    func map<T>(_ transform: (Success) -> T) -> ResultChain<T, Failure> {
        switch self {
        case .success(let value):
            return .success(transform(value))
        case .failure(let error):
            return .failure(error)
        }
    }

    // MARK: - FlatMap allows chaining operations that return ResultChain
    func flatMap<T>(_ transform: (Success) -> ResultChain<T, Failure>) -> ResultChain<T, Failure> {
        switch self {
        case .success(let value):
            return transform(value)
        case .failure(let error):
            return .failure(error)
        }
    }

    // MARK: - Recover transforms an error into a success
    func recover(_ transform: (Failure) -> Success) -> ResultChain {
        switch self {
        case .success(let value):
            return .success(value)
        case .failure(let error):
            return .success(transform(error))
        }
    }

    // MARK: - Catch allows handling error without transforming
    func `catch`(_ handler: (Failure) -> Void) -> ResultChain {
        if case .failure(let error) = self {
            handler(error)
        }
        return self
    }

    // MARK: - Getters
    var value: Success? {
        if case .success(let val) = self { return val }
        return nil
    }

    var error: Failure? {
        if case .failure(let err) = self { return err }
        return nil
    }

    // MARK: Parses JSON data into a Decodable type
    func parseJSON<T: Decodable>(to type: T.Type, using decoder: JSONDecoder = .init()) -> ResultChain<T, Error> {
        switch self {
        case .success(let data):
            do {
                let decoded = try decoder.decode(T.self, from: data as! Data)
                return .success(decoded)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }

}
