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

      print("Start loading \"\(url.absoluteString)\"")
      let request = URLRequest(url: url)
      webView?.loadRequest(request)
    }
  }

  @IBOutlet fileprivate weak var webView: UIWebView!
  @IBOutlet fileprivate weak var activityIndicator: UIActivityIndicatorView!

  override func viewDidLoad() {
    super.viewDidLoad()

    if let url = url {
      self.url = url
    }
  }
}

extension WebViewController: UIWebViewDelegate {

  func webViewDidStartLoad(_ webView: UIWebView) {
    activityIndicator.startAnimating()
  }

  func webViewDidFinishLoad(_ webView: UIWebView) {
    activityIndicator.stopAnimating()
  }

  func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
    activityIndicator.stopAnimating()
  }
}
