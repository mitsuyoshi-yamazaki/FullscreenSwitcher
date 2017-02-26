//
//  ViewController.swift
//  FullscreenSwitcher
//
//  Created by Yamazaki Mitsuyoshi on 2017/02/26.
//  Copyright © 2017 Mitsuyoshi Yamazaki. All rights reserved.
//

import UIKit
import FullscreenSwitcher

final class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    showMainView()
  }

  // MARK: -
  private func showMainView() {

    let switcherController = FullscreenSwitcherController()
    switcherController.modalTransitionStyle = .crossDissolve

    let dummyFullscreenViewController = UIViewController()
    dummyFullscreenViewController.view.backgroundColor = UIColor.red
    switcherController.fullscreenViewController = dummyFullscreenViewController

    let dummyContentViewController = UIViewController()
    dummyContentViewController.view.backgroundColor = UIColor.yellow
    switcherController.contentViewController = dummyContentViewController

    switcherController.switchButtonConfiguration = { (button, superViewFrame) in
      button.setTitle("RED!!", for: .normal)
      button.backgroundColor = UIColor.darkGray
      button.setTitleColor(UIColor.white, for: .normal)
      button.frame = CGRect(x: 0.0, y: superViewFrame.size.height - 40.0, width: 100.0, height: 40.0)
      button.autoresizingMask = [ .flexibleTopMargin, .flexibleRightMargin ]
    }

    self.present(switcherController, animated: true, completion: nil)
  }
}
