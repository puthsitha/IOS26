//
//  ViewController.swift
//  IOS26
//
//  Created by Puthsitha's HTB Mac Pro on 03/11/2025.
//

import UIKit

// MARK: - Root Tab Bar Controller
class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    private func setupTabs() {
        // Home
        let homeVC = HomeViewController()
        homeVC.title = "Home"
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))

        // Contact
        let contactVC = SimpleViewController(title: "Contact", backgroundColor: .systemBackground)
        let contactNav = UINavigationController(rootViewController: contactVC)
        contactNav.tabBarItem = UITabBarItem(title: "Contact", image: UIImage(systemName: "phone"), selectedImage: UIImage(systemName: "phone.fill"))

        // About
        let aboutVC = SimpleViewController(title: "About", backgroundColor: .systemBackground)
        let aboutNav = UINavigationController(rootViewController: aboutVC)
        aboutNav.tabBarItem = UITabBarItem(title: "About", image: UIImage(systemName: "info.circle"), selectedImage: UIImage(systemName: "info.circle.fill"))

        viewControllers = [homeNav, contactNav, aboutNav]

        // Optional: Appearance tweaks for tab bar
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}

// MARK: - Home View Controller with Nav Bar Buttons
final class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .secondarySystemBackground
        configureNavigationBar()
        configureContent()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Re-apply gradient with updated width when layout changes
        configureNavigationBar()
    }
    
    private func gradientImage(size: CGSize, colors: [UIColor], locations: [CGFloat]? = nil) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let cgColors = colors.map { $0.cgColor }
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations) else { return }
            let start = CGPoint(x: 0, y: 0)
            let end = CGPoint(x: size.width, y: 0)
            context.cgContext.drawLinearGradient(gradient, start: start, end: end, options: [])
        }
    }

    private func configureNavigationBar() {
        // Centered title by default on iPhone; ensure standard title (not large)
        navigationItem.title = "Home"

        // Use standard (small) title, not large
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false

		// iOS below 26: force plain, opaque look (no glass effect)
		let leftButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(didTapLeft))
		leftButton.tintColor = .systemGreen
		navigationItem.leftBarButtonItem = leftButton
//		if #available(iOS 26.0, *) {
//			navigationItem.leftBarButtonItem?.hidesSharedBackground = true // 👈 here
//		}
	
        // Right custom icon
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(didTapRight))
        navigationItem.rightBarButtonItem = rightButton

        // Optionally customize appearance with gradient background
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
		appearance.backgroundColor = .systemBackground // or any color you like
		
		let navigationBar = UINavigationBar.appearance()
		navigationBar.standardAppearance = appearance
		navigationBar.scrollEdgeAppearance = appearance
		navigationBar.compactAppearance = appearance
		navigationBar.isTranslucent = false
		navigationBar.barStyle = .black


        // Create a gradient image sized to the navigation bar's current bounds
        let barSize = CGSize(width: view.bounds.width, height: navigationController?.navigationBar.bounds.height ?? 44)
        let gradientColors: [UIColor] = [
            UIColor.systemPurple,
            UIColor.systemBlue
        ]
        if let image = gradientImage(size: barSize, colors: gradientColors) {
            appearance.backgroundImage = image
            appearance.shadowColor = .clear
        } else {
            appearance.backgroundColor = UIColor.systemBlue
        }

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        if #available(iOS 15.0, *) {
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        navigationController?.navigationBar.tintColor = .white // bar button items
    }

    private func configureContent() {
        let label = UILabel()
        label.text = "Home"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func didTapLeft() {
        // Handle left button tap
//        let alert = UIAlertController(title: "Left", message: "Left bar button tapped.", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        present(alert, animated: true)
    }

    @objc private func didTapRight() {
        // Handle right button tap
        let alert = UIAlertController(title: "Right", message: "Right custom icon tapped.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Simple Placeholder VC for Contact & About
final class SimpleViewController: UIViewController {
    private let titleText: String
    private let bgColor: UIColor

    init(title: String, backgroundColor: UIColor) {
        self.titleText = title
        self.bgColor = backgroundColor
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = bgColor

        navigationItem.largeTitleDisplayMode = .never

        let label = UILabel()
        label.text = titleText
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

