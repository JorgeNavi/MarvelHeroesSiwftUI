import Foundation

//Posible Codes for API responses
struct HTTPResponseCodes {
    static let success = 200
    static let Invalid = 401 //Invalid Referer or Hash
    static let Forbidden = 403
    static let NotFound = 404
    static let MethodNotAllowed = 405
    static let MissingParameters = 409 //Missing API Key, hash or Timestamp
}
