import UIKit

enum ShareImageExtensionViewControllers: String {
  case Destination
  
  func instantiate() -> UIViewController? {
    let bundle = NSBundle(forClass: ShareViewController.self)
    
    let storyboard = UIStoryboard(name: ShareImageExtensionConstants.storyboardNames.main,
      bundle: bundle)
    
    return storyboard.instantiateViewControllerWithIdentifier(rawValue)
  }
}