//
//  URLSessionNetworkDispatcher.swift
//  iOS-Challenge
//
//  Created by Saeed Dehshiri on 4/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

public protocol NetworkDispatcher {
    func dispatch<T: Encodable>(request: RequestData<T>, onSuccess: @escaping (Data, _ statusCode: Int) -> Void, onError: @escaping (Error) -> Void)
}

// Base singlethone class for request manager
public struct URLSessionNetworkDispatcher: NetworkDispatcher {
    public static let instance = URLSessionNetworkDispatcher()
    private init() {}
    
    // Easy to use for sending request to server :|
    public func dispatch<T: Encodable>(request: RequestData<T>, onSuccess: @escaping (Data, _ statusCode: Int) -> Void, onError: @escaping (Error) -> Void) {
        
        // Create URL
        guard let url = URL(string: request.path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
            onError(ConnError.invalidURL)
            return
        }
        print("URLSSSSS:\(request.path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")
        
        // Set method
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        let boundary = "Boundary-\(UUID().uuidString)"
        
        // Set params
        do {
            if let params = request.params {
                let jsonEncoder = JSONEncoder()
                let result = try jsonEncoder.encode(params)
                
                if request.method.rawValue == "POST" || request.method.rawValue == "PUT" || request.method.rawValue == "PATCH" {
                    print(String.init(data: result, encoding: .utf8)!)
                    
                    switch request.requestType ?? RequestType.applicationJson {
                    case .applicationJson:
                        urlRequest.httpBody = result
                    case .multiPart:
                        let httpMultipartBody = NSMutableData()
                        
                        let json = try? JSONSerialization.jsonObject(with: result, options: [])
                        
                        if let multipartData = json as? [String: Any] {
                            for (key, value) in multipartData {
                                
                                httpMultipartBody.appendString(convertFormField(named: key, value: "\(value)", using: boundary))
                            }
                        }
                        
                        httpMultipartBody.append(convertFileData(fieldName: request.imageFieldName ?? "image_field",
                                                        fileName: request.imageFileName ?? "imagename.png",
                                                        mimeType: request.imageMimeType ?? "image/png",
                                                        fileData: request.imageData ?? Data(),
                                                        using: boundary))
                        httpMultipartBody.appendString("--\(boundary)--")
                        urlRequest.httpBody = httpMultipartBody as Data
                        
                    }
                    
                }
            }
        } catch let error {
            onError(error)
            return
        }
        
        // Set Token
        let token = DataManager.shared.getToken()
        let tokenType = DataManager.shared.getTokenType()
        if !token.isEmpty {
            print("Token \(token)")
            urlRequest.addValue("\(tokenType) \(token)", forHTTPHeaderField: "Authorization")
        }
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        switch request.requestType ?? RequestType.applicationJson {
        case .applicationJson:
            urlRequest.addValue(RequestType.applicationJson.rawValue, forHTTPHeaderField: "Content-Type")
        case .multiPart:
            urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        }
        
        urlRequest.addValue(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "", forHTTPHeaderField: "AppVersion")
        urlRequest.addValue("IOS", forHTTPHeaderField: "Platform")
        urlRequest.addValue("Mobile", forHTTPHeaderField: "Type")
        urlRequest.addValue(UUID().uuidString, forHTTPHeaderField: "UUID")
        
        // Send Request
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            let _statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            
            if let error = error {
                onError(error)
                return
            }
            
            guard let _data = data else {
                onError(ConnError.noData)
                return
            }
            
            onSuccess(_data, _statusCode)

        }.resume()
        
    }
    
    func convertFormField(named name: String, value: String, using boundary: String) -> String {
      var fieldString = "--\(boundary)\r\n"
      fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
      fieldString += "\r\n"
      fieldString += "\(value)\r\n"

      return fieldString
    }
    
    func convertFileData(fieldName: String, fileName: String, mimeType: String, fileData: Data, using boundary: String) -> Data {
      let data = NSMutableData()

      data.appendString("--\(boundary)\r\n")
      data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
      data.appendString("Content-Type: \(mimeType)\r\n\r\n")
      data.append(fileData)
      data.appendString("\r\n")

      return data as Data
    }
    
    

}

extension NSMutableData {
  func appendString(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
