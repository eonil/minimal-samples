import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    /// - Implementing this method and placing some stuffs in `Info.plist` is enough for app-side.
    /// - But OS won't recognize the app until you once place the app package into `/Applications` or `/Users/Applications` folder.
    /// - It seems becuase of security/privacy issue.
    /// - So just copy the app into an `Applications` folder to make it accept file drops.
    /// - It's unclear what will happen if you remove the app from `/Applications` folder.
    /// - https://stackoverflow.com/questions/2489961/dropping-files-onto-dock-icon-in-cocoa
    func application(_ sender: NSApplication, openFiles filenames: [String]) {
        dump(filenames)
        let x = NSAlert()
        x.messageText = filenames.joined(separator: "\n")
        x.runModal()
    }
}

