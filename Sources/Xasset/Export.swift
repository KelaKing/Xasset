//
//  Export.swift
//  Xasset
//
//  Created by KelaKing on 2019/12/10.
//

import Foundation
import SwiftShell

func export(at: URL, to: URL) throws {
    guard Files.fileExists(atPath: at.path) else {
        exit(errormessage: "\(at) no exist")
    }

    // Create output directory if not exist.
    if !Files.fileExists(atPath: to.path) {
        try Files.createDirectory(atPath: to.path, withIntermediateDirectories: true, attributes: nil)
    }

    let resourceKeys: [URLResourceKey] = [.nameKey, .isDirectoryKey]

    let xcassetEnumerator = Files.enumerator(
        at: at,
        includingPropertiesForKeys: resourceKeys,
        options: [
            .skipsHiddenFiles,
        ],
        errorHandler: nil
    )!

    var count = 0
    for case let fileURL as URL in xcassetEnumerator {
        guard let resourceValues = try? fileURL.resourceValues(forKeys: Set(resourceKeys)),
            let isDirectory = resourceValues.isDirectory,
            !isDirectory,
            let name = resourceValues.name,
            name.hasSuffix(".png") else {
                continue
        }
        let outputURL = to.appendingPathComponent(name)
        try Files.copyItem(at: fileURL, to: outputURL)
        count += 1
    }
    main.stdout.print("export \(count) images 👏")
}
