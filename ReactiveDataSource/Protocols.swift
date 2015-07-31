import Foundation
import ReactiveCocoa

public protocol Actionable {
    // Imagine all the possiblities
}

public protocol Bindable {
    func bind(viewModel: Reusable, pushback: Action<Actionable, Actionable, NoError>?, reuse: Signal<Void, NoError>?)
    func unbind()
}

public protocol Reusable {
    var reuseIdentifier: String { get }
}

public protocol ReusableCell: Reusable {
    var height: CGFloat { get }
    var estimatedHeight: CGFloat { get }
}

public typealias ReusableHeader = ReusableCell
public typealias ReusableFooter = ReusableCell

@objc
public protocol UITableViewDataSourceProxy: NSObjectProtocol {
    
//    @available(iOS 2.0, *)
//    optional func tableViewProxy(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    
//    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
//    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
//    
//    @available(iOS 2.0, *)
//    optional func tableViewProxy(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
//    
//    @available(iOS 2.0, *)
//    optional func numberOfSectionsInTableViewProxy(tableView: UITableView) -> Int // Default is 1 if not implemented
    
    @available(iOS 2.0, *)
    optional func tableViewProxy(tableView: UITableView, titleForHeaderInSection section: Int) -> String? // fixed font style. use custom view (UILabel) if you want something different
    @available(iOS 2.0, *)
    optional func tableViewProxy(tableView: UITableView, titleForFooterInSection section: Int) -> String?
    
    // Editing
    
    // Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
    @available(iOS 2.0, *)
    optional func tableViewProxy(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    
    // Moving/reordering
    
    // Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
    @available(iOS 2.0, *)
    optional func tableViewProxy(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool
    
    // Index
    
    @available(iOS 2.0, *)
    optional func sectionIndexTitlesForTableViewProxy(tableView: UITableView) -> [String]? // return list of section titles to display in section index view (e.g. "ABCD...Z#")
    @available(iOS 2.0, *)
    optional func tableViewProxy(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int // tell table which section corresponds to section title/index (e.g. "B",1))
    
    // Data manipulation - insert and delete support
    
    // After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
    // Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
    @available(iOS 2.0, *)
    optional func tableViewProxy(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    
    // Data manipulation - reorder / moving support
    
    @available(iOS 2.0, *)
    optional func tableViewProxy(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath)
}
