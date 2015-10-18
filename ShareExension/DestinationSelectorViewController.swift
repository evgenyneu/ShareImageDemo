import UIKit

class DestinationSelectorViewController: UITableViewController {
  
  var didSelectDestination: ((String)->())?
  var selectedDestination: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Remove rows from the bottom of the table view
    tableView.tableFooterView = UIView(frame: CGRect())
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    selectRowForCurrentDestination()
  }
  
  private func selectRowForCurrentDestination() {
    guard let selectedDestination = selectedDestination else { return }
    guard let rowIndex = rowIndexWithText(selectedDestination) else { return }
    
    let indexPath = NSIndexPath(forRow: rowIndex, inSection: 0)
    
    guard let selectedCell = tableView.dataSource?.tableView(
      tableView, cellForRowAtIndexPath: indexPath) else { return }
    
    selectedCell.setSelected(true, animated: true)
  }
  
  
  /// Returns the index for the row that matches the text
  func rowIndexWithText(text: String) -> Int? {
    let numberOfRows = tableView(tableView, numberOfRowsInSection: 0)
    
    for rowIndex in (0..<numberOfRows) {
      let indexPath = NSIndexPath(forRow: rowIndex, inSection: 0)
      
      guard let cell = tableView.dataSource?.tableView(
        tableView, cellForRowAtIndexPath: indexPath) else { break }
      
      let text = cell.textLabel?.text
      
      if text == selectedDestination {
        return rowIndex
      }
    }
    
    return nil
  }
  
  // MARK: - UITableViewDelegate
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    guard let selectedCell = tableView.dataSource?.tableView(
      tableView, cellForRowAtIndexPath: indexPath) else { return }
  
    guard let selectedText = selectedCell.textLabel?.text else { return }
    
    didSelectDestination?(selectedText)
    navigationController?.popViewControllerAnimated(true)
  }
}

