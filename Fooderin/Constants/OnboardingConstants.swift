//
//  OnboardingConstants.swift
//  Fooderin
//
//  Created by Алексей Павленко on 19.09.2022.
//

import Foundation

struct OnboardingConstants {
    static let slides: [OnboardingSlide] = [
        OnboardingSlide(title: "Delicious Dishes", description: "Experience a variety of amazing dishes from different cultures around the world", imageName: "dish"),
        OnboardingSlide(title: "World-Class Chefs", description: "Our dishes are prepaired only by the best", imageName: "chef"),
        OnboardingSlide(title: "Instant World-Wide Delivery", description: "Your orders will be delivered instantly irrespective of your location around the world", imageName: "delivery")
    ]
    private init() { }
}
