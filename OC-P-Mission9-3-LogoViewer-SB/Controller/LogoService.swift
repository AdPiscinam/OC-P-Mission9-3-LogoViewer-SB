// LogoService.swift
// OC-P-Mission9-3-LogoViewer-SB
// Created by Ad Piscinam on 05/04/2022
// Copyright © 2022 OpenClassrooms. All rights reserved.

import Foundation

class LogoService {
    
    static let shared = LogoService()
    private init() {}

    private let baseUrl = "https://logo.clearbit.com/"
    private var task: URLSessionDataTask?
    
 
    
    func getLogo(domain: String, callback: @escaping (Bool, Data?) -> Void) {
        let session = URLSession(configuration: .default)

        guard let url = URL(string: baseUrl + domain) else {
            callback(false, nil)
            return
        }

        task?.cancel()
        task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(false, nil)
                        return
                }

                callback(true, data)
            }
        }
        task?.resume()
    }
    
}
