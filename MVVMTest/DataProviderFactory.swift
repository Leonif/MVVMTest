//
// Created by Leonid Nifantyev on 2019-07-05.
// Copyright (c) 2019 Nifantyev. All rights reserved.
//

import DataLayer
import UIKit

public class DataProviderFactory {

  public class func createPersistenceManager() -> PersistenceProviderInterface {
    return PersistenceProvider()
  }
  
  func assemble() -> PersistenceProviderInterface {
    return (UIApplication.shared.delegate as? AppDelegate)!.persistenceProvider
  }
}
