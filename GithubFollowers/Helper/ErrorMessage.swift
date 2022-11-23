//
//  File.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 23.11.2022.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidUsername = "The username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again"
    case decodingData = "Error while decoding data"
}
