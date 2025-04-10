//
//  InfoViewController.swift
//  the-movie-db
//
//  Created by Zan on 4/9/25.
//  Copyright © 2025 Zan. All rights reserved.
//


import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
    }

    private func navigateToTermsAndCondition(
        title: String,
        desc: String
    ) {
        let vc = TermsAndConditionVieController(with: title, with: desc)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction
    func didTapAboutUs(_ sender: UIButton) {
        navigateToTermsAndCondition(
            title: "About Us",
            desc: """
                Welcome to MovieSwift – your gateway to discovering the latest movies effortlessly!
                
                This app is a simple yet powerful Swift-based iOS project designed to demonstrate the
                integration of Core Data and REST APIs. Upon launching the app, users are presented with a
                curated list of the most recent movies fetched from a live API. With just a tap on the
                "Favorite" button, users can store their selected movies locally using Core Data, enabling
                quick access to their favorite movie list anytime — even offline.
                
                Whether you're a developer exploring iOS capabilities or a movie lover keeping track of your
                top picks, MovieSwift offers a clean, user-friendly experience built with modern iOS
                development principles.
                """
        )
    }
    
    @IBAction
    func didTapTermsAndConditions(_ sender: UIButton) {
        navigateToTermsAndCondition(
            title: "Terms and Conditions",
            desc: """
                By using the MovieSwift mobile application, you agree to the following terms and conditions:
                
                1. Data Usage: MovieSwift fetches public movie information via a third-party REST API. No personal or sensitive data is collected, shared, or stored by the app.
                
                2. Core Data Storage: Favorites are stored locally on your device using Apple's Core Data framework. This data is not shared with any external server or third party.
                
                3. Intellectual Property: All app code and design belong to the developer. Movie content and images are sourced via an external API and are the property of their respective owners.
                
                4. Limitation of Liability: While we strive to provide accurate and up-to-date movie information, we are not liable for any discrepancies or downtime related to the external API services.
                
                5. Changes to the App: The app may receive updates to improve functionality, design, or performance. We reserve the right to modify or discontinue the app at any time.
                
                By continuing to use this app, you acknowledge that you have read and agree to these terms.
                """
        )
    }

}
