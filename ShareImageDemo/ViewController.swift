import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()    
  }
  
  // Change the status bar text color to white
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
}

