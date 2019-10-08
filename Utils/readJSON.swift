//
// Created by Leonid Nifantyev on 2019-05-29.
// Copyright (c) 2019 Nifantyev. All rights reserved.
//

//import Utils


/// Read JSON mock from project bundle
///
/// - Parameter name: name of JSON file without extension
/// - Returns: data type as service should decode it
public func readJsonFile(name: String) -> Data? {
    let url: URL = Bundle(identifier: "GMEM.DataLayer")!.url(forResource: name, withExtension: "json")!
    do {
        let jsonData = try Data(contentsOf: url)
        return jsonData
    }
    catch {
        print(error)
        return nil
    }
}


//public func readJsonFileAsync(name: String) -> Subject<(Data?, Error?)> {
//    let url: URL = Bundle(identifier: "GMEM.DataLayer")!.url(forResource: name, withExtension: "json")!
//    let subject = Subject<(Data?, Error?)>()
//    do {
//        let jsonData = try Data(contentsOf: url)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
//            subject.value = (jsonData, .none)
//        }
//    }
//    catch {
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
//            subject.value = (.none, error)
//        }
//    }
//    return subject
//}
