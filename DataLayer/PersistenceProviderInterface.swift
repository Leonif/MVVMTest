//
// Created by Leonid Nifantyev on 2019-07-05.
// Copyright (c) 2019 Nifantyev. All rights reserved.
//

import Foundation

public protocol PersistenceProviderInterface {
  func fetchAllRecords<Entity: Persistanble>() -> [Entity]
  func fetchRecord<Entity: Persistanble>(with id: String) -> Entity?
  func saveRecord<Entity: Persistanble>(saveCode: @escaping (Entity) -> Void, completion: @escaping (Bool) -> Void)
  
  func removeRecord<Entity: Persistanble>(with id: String, from: Entity.Type)
  func removeAllRecord<Entity:Persistanble>(_: Entity.Type, callback: @escaping () -> Void)
}
