//
//  FullscreenSwitcherController.swift
//  FullscreenSwitcher
//
//  Created by Yamazaki Mitsuyoshi on 2017/02/26.
//  Copyright © 2017 Mitsuyoshi Yamazaki. All rights reserved.
//

import UIKit

public class FullscreenSwitcherController: UIViewController {

    // MARK: - Accessor
    // MARK: Public
    public var fullscreenViewController: UIViewController! {
        didSet {
            addChildViewController(fullscreenViewController)
            fullscreenViewController.didMove(toParentViewController: self)
        }
    }
    public var contentViewController: UIViewController! {
        didSet {
            addChildViewController(contentViewController)
            contentViewController.didMove(toParentViewController: self)
        }
    }
    public var switchButton: UIButton! {
        didSet {

        }
    }

    // MARK: Private
    private let fullscreenView: UIView = {

        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]

        return view
    }()

    private let contentView: UIView = {

        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]

        return view
    }()

    // MARK: - Lifecycle
    override public func viewDidLoad() {
        super.viewDidLoad()

        assert(fullscreenViewController != nil, "fullscreenViewController cannot be nil")
        assert(contentViewController != nil, "contentViewController cannot be nil")

        fullscreenView.frame = view.bounds
        view.addSubview(fullscreenView)

        contentView.frame = view.bounds
        view.addSubview(contentView)
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fullscreenView.addSubview(fullscreenViewController.view)
        fullscreenViewController.view.frame = view.bounds

        contentView.addSubview(contentViewController.view)
        contentViewController.view.frame = view.bounds
    }
}
