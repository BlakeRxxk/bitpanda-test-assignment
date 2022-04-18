//
//  AppDelegate.swift
//  BitPanda
//
//  Created by Oleg Kurgaev on 12.04.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow()
    guard let window = window else { return false }

    window.rootViewController = ViewController()
    window.makeKeyAndVisible()

    return true
  }

}
