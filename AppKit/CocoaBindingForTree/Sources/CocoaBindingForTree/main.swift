import Cocoa
import AppKit

///
/// Eonil, 2020.
///
/// I could make it work but only in immutable and oneway manner.
/// I have no idea how to make it work mutable and bidirectionally.
///
/// Discouraged
/// -----------
/// - I do not recommend using of NSTreeController or Cocoa Binding at all.
/// - They are too error prone, and difficult to setup correctly.
/// - This was expecting to cut some implementation cost, but Cocoa Binding is very unlikely.
///   - It cuts some cost, but also introduces more cost due to lack of type check or dynamic assertions.
/// - If Cocoa Binding can provide completely correct NSOutlineView controlling with simplified model it can help some level.
///   - Anyway, it still would need a sort of wrapper model.
///
/// References
/// ----------
/// - https://stackoverflow.com/questions/42788993/programmatically-binding-nstreecontroller-to-nsoutlineview
/// - https://medium.com/building-ibotta/nstreecontroller-nsoutlineview-a-powerful-combination-ca17fd233139

let app = NSApplication.shared
let win = NSWindow()
let scroll = NSScrollView()
let outline = NSOutlineView()
let column = NSTableColumn()
let tree = NSTreeController()
let roots = NSMutableArray()
app.setActivationPolicy(.regular)
win.makeKeyAndOrderFront(nil)
win.styleMask.formUnion([.closable, .resizable])
win.contentView = scroll
scroll.documentView = outline
outline.headerView = nil
outline.addTableColumn(column)
outline.outlineTableColumn = column
outline.bind(.content, to: tree, withKeyPath: "arrangedObjects", options: nil)
tree.childrenKeyPath = "children"
tree.content = roots
roots.insert([SampleNode(), SampleNode(), SampleNode()], at: [0,1,2])

autoreleasepool { app.run() }
withExtendedLifetime((app,win), noop)

func noop() {}
func noop<T>(_:T) {}

@objc class SampleNode: NSObject {
    @objc var isLeaf = false
    @objc var children = NSMutableArray()
}
