//
//  EnableSwipeBackGesture.swift
//  Renshuu
//
//  Created by Roland Kajatin on 10/05/2025.
//

import SwiftUI

struct EnableSwipeBackGesture: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        DispatchQueue.main.async {
            if let navController = controller.navigationController {
                navController.interactivePopGestureRecognizer?.isEnabled = true
                navController.interactivePopGestureRecognizer?.delegate = nil
            }
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
