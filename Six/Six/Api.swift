//
//  Api.swift
//  Six
//
//  Created by Jax on 2021/1/5.
//  Copyright © 2021 luxshare-ict. All rights reserved.
//

import Foundation
import Moya


// swiftlint:disable force_unwrapping

import Foundation
import Moya

// MARK: - Provider setup

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

let apiProvider = MoyaProvider<Api>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

// MARK: - Provider support

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum Api {
    case list
    case englishdaily(Int,String)
    case commapi(String)
}

extension Api: TargetType {
    public var baseURL: URL { return URL(string: "http://english.leanapp.cn")! }
    public var path: String {
        switch self {
        case .list:
            return "/api/v1/publisher/info"
        case .englishdaily(_,_):
            return "/feed"
        case .commapi(_):
            return "/feed"
        }
    }
    public var method: Moya.Method {
        return .get
    }
    public var task: Task {
        switch self {
        case .list:
            return .requestParameters(parameters: ["app": "6minenglish6"], encoding: URLEncoding.default)
        case .englishdaily(_,let path):
            return .requestParameters(parameters: ["limit": 10,"s":path,"syncText":1], encoding: URLEncoding.default)
        case .commapi(let path):
            return .requestParameters(parameters: ["limit": 10,"s":path,"syncText":1], encoding: URLEncoding.default)
//        default:
//            return .requestPlain
        }
    }
    public var validationType: ValidationType {
        return .none
//        switch self {
//        case .zen:
//            return .successCodes
//        default:
//            return .none
//        }
    }
    public var sampleData: Data {
        switch self {
        case .list:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        case .englishdaily:
            return "{\"login\": \"jax\", \"id\": 100}".data(using: String.Encoding.utf8)!
        default:
            return "{\"login\": \"jax\", \"id\": 100}".data(using: String.Encoding.utf8)!
        }
    }
    public var headers: [String: String]? {
        return ["Accept":"*/*","User-Agent":"EnglishTalent/4.8.1 (iPhone; iOS 14.2; Scale/2.00)"]
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}

// MARK: - Response Handlers

extension Moya.Response {
    func mapNSArray() throws -> NSArray {
        let any = try self.mapJSON()
        guard let array = any as? NSArray else {
            throw MoyaError.jsonMapping(self)
        }
        return array
    }
}

