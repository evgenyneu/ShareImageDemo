import UIKit
import Social
import MobileCoreServices

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
    
    guard let extensionContext = extensionContext else { return }
    
    ShareViewController.sharedImageData(extensionContext) { [weak self] imageData in
      
      if let imageData = imageData, weakSelf = self {
        weakSelf.postImage(imageData, imageName: weakSelf.textView.text)
      }
      
      extensionContext.completeRequestReturningItems([], completionHandler: nil)
    }
  }
  
  func postImage(imageData: NSData, imageName: String) {
    // Send the image to the server here with a background NSURLSession download/upload task
    print("Sending image to the web server")
  }
  
  /// Calls `result` closure with the shared image data or with nil parameter.
  private static func sharedImageData(extensionContext: NSExtensionContext, result: (NSData?)->()) {
    let imageType = kUTTypeImage as String

    if let item = extensionContext.inputItems.first as? NSExtensionItem,
      attachment = item.attachments?.first as? NSItemProvider where
      attachment.hasItemConformingToTypeIdentifier(imageType) {
      attachment.loadItemForTypeIdentifier(imageType, options: nil) { url, error in
        guard let url = url as? NSURL else {
          result(nil)
          return
        }
        
        result(NSData(contentsOfURL: url))
        return
      }
    } else {
      result(nil)
      return
    }
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
