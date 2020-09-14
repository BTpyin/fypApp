//
//  UIStoryBoard+Create.swift
//  fypApp
//
//  Created by Bowie Tso on 14/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//
import UIKit
extension UIStoryboard {
    enum Storyboard: String {
        case main = "Main"

    }

 static func storyboard(_ storyboard: Storyboard) -> UIStoryboard {
    return UIStoryboard.init(name: storyboard.rawValue, bundle: nil)
  }

  func instantiateViewController<T: UIViewController>(_ vcClass: T.Type) -> T? {
    let viewControllerTypeName: String = String(describing: T.self)
    guard let vc = instantiateViewController(withIdentifier: viewControllerTypeName) as? T else {
      fatalError("Could not locate viewcontroller with with identifier \(viewControllerTypeName) in storyboard.")
    }
    return vc
  }
}
