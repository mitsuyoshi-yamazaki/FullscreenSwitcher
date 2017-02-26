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

//    let imageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ImageViewController")
//    switcherController.fullscreenViewController = imageViewController

    let qrCodeViewController = QRRecognitionViewController()
    switcherController.fullscreenViewController = qrCodeViewController

    let webViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController")
    switcherController.contentViewController = webViewController

    switcherController.switchButtonConfiguration = { (button, superViewFrame) in

      button.backgroundColor = UIColor.clear
      button.setImage(#imageLiteral(resourceName: "QRButton"), for: .normal)
      let size: CGFloat = 92.0
      button.frame = CGRect(x: 0.0, y: superViewFrame.size.height - size, width: size, height: size)
      button.autoresizingMask = [ .flexibleTopMargin, .flexibleRightMargin ]
    }

    self.present(switcherController, animated: true, completion: nil)
  }
}
