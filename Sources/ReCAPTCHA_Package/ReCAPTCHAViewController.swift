import UIKit
import WebKit

@objc public final class ReCAPTCHAViewController: UIViewController {
    private var webView: WKWebView!
    private let viewModel: ReCAPTCHAViewModel

    @objc public init(viewModel: ReCAPTCHAViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        let contentController = WKUserContentController()

        contentController.add(viewModel, name: "recaptcha")
        webConfiguration.userContentController = contentController

        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        view = webView
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        let buttonType: UIBarButtonItem.SystemItem
        if #available(iOS 13.0, *) {
            buttonType = .close
        } else {
            buttonType = .cancel
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: buttonType,
            target: self,
            action: #selector(didSelectCloseButton)
        )

        webView.loadHTMLString(viewModel.html, baseURL: viewModel.url)
    }
}

// MARK: - Target-Actions
private extension ReCAPTCHAViewController {
    @IBAction func didSelectCloseButton() {
        dismiss(animated: true)
    }
}
