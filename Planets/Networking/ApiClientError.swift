enum ApiClientError: Error {
    case httpCodeError(code: Int)
    case urlError
}

