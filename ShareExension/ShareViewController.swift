import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {
  var currentlySelectedDestination = "Images"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTextView()
  }
  
  private func configureTextView() {
    placeholder =  "Enter image file name"
    textView.autocapitalizationType = .None
    textView.autocorrectionType = .No
  }
  
  override func isContentValid() -> Bool {
    // Do validation of contentText and/or NSExtensionContext attachments here
    return true
  }
  
  override func didSelectPost() {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
  }
  
  override func configurationItems() -> [AnyObject]! {
    let item = SLComposeSheetConfigurationItem()
    
    item.title  = "Destination"
    item.value = currentlySelectedDestination
    
    item.tapHandler = { [weak self] in
      self?.showConfigurationViewController()
    }
    
    return [item]
  }
  
  func showConfigurationViewController() {
    guard let viewController = ShareImageExtensionViewControllers.Destination.instantiate() as? DestinationSelectorViewController else { return }
  
    viewController.didSelectDestination = didSelectDestination
    viewController.selectedDestination = currentlySelectedDestination
    
    pushConfigurationViewController(viewController)
  }
  
  private func didSelectDestination(text: String) {
    currentlySelectedDestination = text
    reloadConfigurationItems()
  }
}
