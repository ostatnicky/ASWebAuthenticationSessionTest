//
//  ViewController.swift
//  ASWebAuthenticationSessionTest
//
//  Created by Jiri Ostatnicky on 05.04.2024.
//

import AuthenticationServices
import UIKit

class ViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Private
private extension ViewController {
    
    func setupUI() {
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    @objc func didTap() {
        auth()
    }
    
    func auth() {
        // Use the URL and callback scheme specified by the authorization provider.
        guard let authURL = URL(string: "https://example.com/auth") else { return }
        let scheme = "exampleauth"


        // Initialize the session.
        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: scheme)
        { callbackURL, error in
            // Handle the callback.
        }
        
        session.presentationContextProvider = self
        session.prefersEphemeralWebBrowserSession = true
        
        session.start()
    }
}

// MARK: - ASWebAuthenticationPresentationContextProviding
extension ViewController: ASWebAuthenticationPresentationContextProviding {
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }
}

