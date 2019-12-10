import SwiftShell
import Foundation

guard main.arguments.count == 2 else {
    exit(errormessage: "XCASSET_PATH OUTPUT_PATH")
}

let xcassetUrlString = main.arguments[0]
guard Files.fileExists(atPath: xcassetUrlString) else {
    exit(errormessage: "\(xcassetUrlString) no exist")
}

let outputUrlString = main.arguments[1]
// Create output directory if not exist.
if !Files.fileExists(atPath: outputUrlString) {
    do {
        try Files.createDirectory(atPath: outputUrlString, withIntermediateDirectories: true, attributes: nil)
    } catch {
        exit(error)
    }
}

let xcassetURL = URL(fileURLWithPath: xcassetUrlString, isDirectory: true)
let outputURL = URL(fileURLWithPath: outputUrlString, isDirectory: true)

print(xcassetURL)
print(outputURL)
