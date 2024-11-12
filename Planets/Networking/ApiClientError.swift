enum ApiClientError: Error {
    case httpCodeError(code: Int)
    case noData
    case urlError
}

