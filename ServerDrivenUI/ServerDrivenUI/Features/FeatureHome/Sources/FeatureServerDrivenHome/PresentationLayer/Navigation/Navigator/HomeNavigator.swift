//
//  HomeNavigator.swift
//  FeatureHome
//
//  Created by Anup Sahu on 24/03/26.
//
//✅ Navigate outside Home feature

@MainActor
public protocol HomeNavigator: Sendable {
    func openProductList()
    
    func openVoiceOver()
}
