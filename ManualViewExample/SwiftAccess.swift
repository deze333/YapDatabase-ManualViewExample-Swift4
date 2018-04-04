//
//  SwiftAccess.swift
//  ManualViewExample
//
//  Created by Denis Zubkov on 4/4/18.
//

import Foundation

class SwiftAccess: NSObject {
    
    class func findPerson(connection: YapDatabaseConnection, extName: String) {
        
        connection.asyncRead({
            tx in
            
            (tx.ext(extName) as? YapDatabaseViewTransaction)?.enumerateRows(inGroup: "", with: NSEnumerationOptions(rawValue: 0), using: {
                collection, key, obj, meta, index, stop in
                
                print("First object:", obj)
                stop.pointee = true
            })
            
        }, completionBlock: {
            print("Completion block")
        })
    }
}
