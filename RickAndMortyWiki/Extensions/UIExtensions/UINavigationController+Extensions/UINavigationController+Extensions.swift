
//
//  Untitled.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 05.06.2025.
//
import UIKit

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
