//
//  QRRecognitionViewController.swift
//  FullscreenSwitcher
//
//  Created by Yamazaki Mitsuyoshi on 2017/02/26.
//  Copyright © 2017 Mitsuyoshi Yamazaki. All rights reserved.
//

import UIKit
import AVFoundation

protocol QRRecognitionViewControllerDelegate: class {
  func qrRecognitionViewControllerDelegate(controller: QRRecognitionViewController, didRecognizeCode qrCode: String)
}

final class QRRecognitionViewController: UIViewController {

  // MARK: - Accessor
  // MARK: Public
  weak var delegate: QRRecognitionViewControllerDelegate?

  // MARK: Private
  fileprivate let captureView: UIView = {

    let view = UIView()
    view.backgroundColor = UIColor.white
    view.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]

    return view
  }()
  fileprivate lazy var qrCodeIndicatorView: UIView = {

    let view = UIView()
    view.backgroundColor = UIColor.clear
    view.autoresizingMask = []
    view.isUserInteractionEnabled = false

    view.layer.borderWidth = 2.0
    view.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1).cgColor

    return view
  }()
  fileprivate lazy var captureSession = AVCaptureSession()
  fileprivate lazy var capturePreviewLayer: AVCaptureVideoPreviewLayer = {
    guard let layer = AVCaptureVideoPreviewLayer(session: self.captureSession) else {
      fatalError()
    }
    return layer
  }()
  fileprivate lazy var captureOutput: AVCaptureMetadataOutput = {
    let output = AVCaptureMetadataOutput()
    output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
    return output
  }()

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    captureView.frame = view.bounds
    view.addSubview(captureView)

    qrCodeIndicatorView.isHidden = true
    view.addSubview(qrCodeIndicatorView)

    setupCaptureSession()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    capturePreviewLayer.frame = captureView.bounds
  }

  fileprivate func setupCaptureSession() {
    do {
      let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
      let captureInput = try AVCaptureDeviceInput(device: captureDevice)
      captureSession.addInput(captureInput)
      captureSession.addOutput(captureOutput)
      captureOutput.metadataObjectTypes = captureOutput.availableMetadataObjectTypes
      capturePreviewLayer.frame = captureView.bounds
      capturePreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
      captureView.layer.addSublayer(capturePreviewLayer)
      captureSession.startRunning()
    } catch let error {
      print(error)
    }
  }
}

extension QRRecognitionViewController: AVCaptureMetadataOutputObjectsDelegate {

  func captureOutput(_ captureOutput: AVCaptureOutput!,
                     didOutputMetadataObjects metadataObjects: [Any]!,
                     from connection: AVCaptureConnection!) {
    captureSession.stopRunning()
    guard let objects = metadataObjects as? [AVMetadataObject] else {
      return
    }

    for metadataObject in objects {
      guard
        metadataObject.type == AVMetadataObjectTypeQRCode,
        let qrCodeObject = metadataObject as? AVMetadataMachineReadableCodeObject,
        let qrCode = qrCodeObject.stringValue
      else {
        continue
      }

      delegate?.qrRecognitionViewControllerDelegate(controller: self, didRecognizeCode: qrCode)

      break // use the first code only
    }

    captureSession.startRunning()
  }
}
