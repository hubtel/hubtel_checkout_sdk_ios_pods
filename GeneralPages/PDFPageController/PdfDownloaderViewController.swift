//
//  PdfDownloaderViewController.swift
//
//
//  Created by Mark Amoah on 10/12/23.
//

import UIKit
import WebKit
import PDFKit
import QuickLook

class PdfDownloaderViewController: UIViewController, QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 2
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let pdfFileURL = documentsDirectory.appendingPathComponent(fileName)
                    return pdfFileURL as QLPreviewItem
                }
                fatalError("PDF file not found")
    }
    
    
    var req: HtmlRequirements?
    
    var momoResponse: MomoResponse?
    
    var formatter: UIPrintFormatter?
    
    weak var delegate: PaymentFinishedDelegate?
    
    lazy var fileName = "\((req?.businessName ?? "").trimmingCharacters(in: .whitespaces))_\((momoResponse?.customerName ?? "").trimmingCharacters(in: .whitespaces))_bank_pay_receipt_\(Date().timeIntervalSince1970 * 1000).pdf"
    
    lazy var bottomButton: CustomButtonView = {
        let button = CustomButtonView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setButtonTitle(with: "DOWNLOAD PDF")
        button.validate(true)
        button.delegate = self
        return button
    }()
    
    init(requirement: HtmlRequirements, checkoutResponse: MomoResponse?, delegate: PaymentFinishedDelegate?){
        super.init(nibName: nil, bundle: nil)
        self.momoResponse = checkoutResponse
        self.req = requirement
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var webView : WKWebView = {
        let webView = WKWebView(frame: .zero, configuration: getWKWebViewConfiguration())
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.layer.cornerRadius = 6
        webView.clipsToBounds = true
        return webView
    }()
    
    private func getWKWebViewConfiguration() -> WKWebViewConfiguration {
        let userController = WKUserContentController()
//        userController.add(self, name: terminalOutputName)
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userController
        return configuration
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.bgColorGray
        self.view.addSubviews(bottomButton, webView)
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        webView.loadHTMLString(HTMLStrings.generateString(requireMents: req!, checkoutResponse: momoResponse), baseURL: nil)
    }
    
    func setupConstraints(){
        let buttonConstraints = [
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(buttonConstraints)
        
        let webViewConstraints = [
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            webView.bottomAnchor.constraint(equalTo: bottomButton.topAnchor, constant: -8),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        ]
        NSLayoutConstraint.activate(webViewConstraints)
    }

    

}

extension PdfDownloaderViewController: ButtonActionDelegate{
    
    func performAction() {
        formatter = webView.viewPrintFormatter()
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(webView.viewPrintFormatter(), startingAtPageAt: 0)
        let page = CGRect(x: 0, y: 0, width: 700, height: 841.8)
        let printable = page.insetBy(dx: 0, dy: 0)
        render.setValue(NSValue(cgRect: page), forKey: "paperRect")
        render.setValue(NSValue(cgRect: printable), forKey: "printableRect")
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRect.zero, nil)
        for i in 0..<render.numberOfPages{
            UIGraphicsBeginPDFPage()
            let bounds = UIGraphicsGetPDFContextBounds()
            render.drawPage(at: i, in: bounds)
        }
        
        UIGraphicsEndPDFContext()
        
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
               let pdfFileURL = documentsDirectory.appendingPathComponent(fileName)
               pdfData.write(to: pdfFileURL, atomically: true)

               // At this point, you can provide options for previewing and downloading the PDF
               // For example, you can present a Quick Look preview controller or create a share sheet.

               // Show a Quick Look preview
               let previewController = QLPreviewController()
               previewController.dataSource = self
               previewController.delegate = self
            self.present(previewController, animated: true)

               // Alternatively, you can share the PDF through UIActivityViewController
               // Create a URL to the saved PDF and pass it to the activity view controller
//               let shareURL = [pdfFileURL]
//               let activityViewController = UIActivityViewController(activityItems: shareURL, applicationActivities: nil)
//               self.present(activityViewController, animated: true, completion: nil)
           }
    }
    
    
    
}

extension PdfDownloaderViewController: QLPreviewControllerDelegate{
    func previewControllerDidDismiss(_ controller: QLPreviewController) {
        self.dismiss(animated: true) {
            self.delegate?.checkStatus(value: .pendingBankPayPayment, transactionId: UserSetupRequirements.transactionId)
            
            UserSetupRequirements.transactionId = ""
        }
    }
}
