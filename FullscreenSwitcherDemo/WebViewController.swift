//
//  WebViewController.swift
//  FullscreenSwitcher
//
//  Created by Yamazaki Mitsuyoshi on 2017/02/26.
//  Copyright © 2017 Mitsuyoshi Yamazaki. All rights reserved.
//

import UIKit

final class WebViewController: UIViewController {

  var url: URL? {
    didSet {
      guard let url = url else {
        return
      }

      let request = URLRequest(url: url)
      webView.loadRequest(request)
    }
  }

  @IBOutlet private weak var webView: UIWebView!

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
