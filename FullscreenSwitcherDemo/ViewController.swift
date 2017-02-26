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

  // MARK: - Accessor
  fileprivate lazy var qrCodeViewController: QRRecognitionViewController = {

    let controller = QRRecognitionViewController()
    controller.delegate = self

    return controller
  }()
  fileprivate lazy var webViewController: WebViewController = {

    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let controller = storyboard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController else {
      fatalError()
    }

    return controller
  }()

  // MARK: - Lifecycle
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

#if IOS_SIMULATOR
    let imageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ImageViewController")
    switcherController.fullscreenViewController = imageViewController

    webViewController.url = URL(string: "https//:google.com")
#else
    switcherController.fullscreenViewController = qrCodeViewController
#endif

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

extension ViewController: QRRecognitionViewControllerDelegate {

  func qrRecognitionViewControllerDelegate(controller: QRRecognitionViewController, didRecognizeCode qrCode: String) {
    guard let url = URL(string: qrCode) else {
      return
    }
    webViewController.url = url
  }
}
