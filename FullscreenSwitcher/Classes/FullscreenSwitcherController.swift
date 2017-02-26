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
  public var switchButtonConfiguration: ((UIButton, CGRect) -> Void)! // swiftlint:disable:this force_unwrapping
  public private(set) var contentViewHidden = false

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

  private let switchButton: UIButton = {

    let button = UIButton()
    button.addTarget(self, action: #selector(hideContentView(sender:)), for: .touchDown)
    button.addTarget(self, action: #selector(showContentView(sender:)), for: [ .touchUpInside, .touchUpOutside ])

    return button
  }()

  private var isAnimating = false

  // MARK: - Lifecycle
  override public func viewDidLoad() {
    super.viewDidLoad()

    assert(fullscreenViewController != nil, "fullscreenViewController cannot be nil")
    assert(contentViewController != nil, "contentViewController cannot be nil")
    assert(switchButtonConfiguration != nil, "switchButton cannot be nil")

    fullscreenView.frame = view.bounds
    view.addSubview(fullscreenView)

    contentView.frame = view.bounds
    view.addSubview(contentView)

    view.addSubview(switchButton)
    switchButtonConfiguration(switchButton, view.bounds)
  }

  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    fullscreenView.addSubview(fullscreenViewController.view)
    fullscreenViewController.view.frame = view.bounds

    contentView.addSubview(contentViewController.view)
    contentViewController.view.frame = view.bounds

  }

  // MARK: - Behavior
  // MARK: Public
  public func hideContentView(sender: AnyObject!) {
    setContentViewHidden(true, animated: true)
  }

  public func showContentView(sender: AnyObject!) {
    setContentViewHidden(false, animated: true)
  }

  public func setContentViewHidden(_ isHidden: Bool, animated: Bool) {  // TODO: use animated
    guard isHidden != contentViewHidden else {
      return
    }

    if isAnimating == true {
      cancelAnimation()
    }

    contentView.isUserInteractionEnabled = false
    contentView.isHidden = false

    UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: { [weak self] _ in

      if isHidden {
        self?.contentView.alpha = 0.0
      } else {
        self?.contentView.alpha = 1.0
      }

    }) { [weak self] (completed) in

      if isHidden {
        self?.contentView.isHidden = true
      } else {
        self?.contentView.isHidden = false
      }
      self?.contentView.isUserInteractionEnabled = true
      self?.contentViewHidden = isHidden
    }
  }

  private func cancelAnimation() {
    // TODO: implement here
  }
}
