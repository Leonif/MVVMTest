//
//  InterestsViewModel.swift
//  MVVMTest
//
//  Created by Leonid Nifantyev on 10/5/19.
//

import Utils
import UIKit
import DataLayer

enum InterestsViewModelEvent {
  case fetched
  case error
}

protocol InterestsViewModelInterface {
  var eventHandler: EventHandler<InterestsViewModelEvent>? { get set }
  func fetch()
  func back()
}

protocol InterestsDataSource {
  func interestsCount() -> Int
  func getItem(for index: Int) -> InterestItem
  func selectedItem(for index: Int)
}

protocol InterestsCoordinatorOutput: class {
  func interestFinished()
}

class InterestsViewModel: InterestsViewModelInterface, InterestsDataSource {
  weak var output: InterestsCoordinatorOutput?
  private var interests: [InterestItem] = [
    InterestItem(id: 0, img: "pen", title: "Art & Design", color: .red, isSelected: false),
    InterestItem(id: 1,img: "", title: "Auto & Vehicle", color: .yellow, isSelected: false),
    InterestItem(id: 2,img: "lipstick", title: "Beauty", color: .green, isSelected: false),
    InterestItem(id: 3, img: "joystick", title: "Games", color: .systemPink, isSelected: false),
    InterestItem(id: 4,img: "", title: "Auto & Vehicle", color: .brown, isSelected: false),
  ]
  
  var persistenceProvider: PitchPersistenceProviderInterface!
  var eventHandler: EventHandler<InterestsViewModelEvent>? = nil
  private var coredataService: Bool = true
  
  func fetch() {
    if !interests.isEmpty {
      append(interests: interests)
      eventHandler?(.fetched)
    } else {
      eventHandler?(.error)
    }
  }
  
  private func append(interests: [InterestItem]) {
    let objects: [Interest] = persistenceProvider.fetchAllRecords()
    let ids = objects.map { $0.id }
    for (index, item) in interests.enumerated() {
      if !ids.contains(item.id.int64) {
        persistenceProvider.saveRecord(saveCode: { (object: Interest) in
          object.id = item.id.int64
          object.img = item.img
          object.title = item.title
          object.isSelected = item.isSelected
          object.color = item.color.stringColor
        }) { _ in }
      } else {
        let object: Interest? = persistenceProvider.fetchRecord(with: item.id.string)
        self.interests[index].isSelected = object?.isSelected ?? false
      }
    }
  }
  
  func back() {
    output?.interestFinished()
  }
  
  func interestsCount() -> Int {
    return interests.count
  }
  
  func getItem(for index: Int) -> InterestItem {
    return interests[index]
  }
  
  func selectedItem(for index: Int) {
    interests[index].isSelected.toggle()
    let item = interests[index]
    persistenceProvider.removeRecord(with: interests[index].id.string, from: Interest.self)
    persistenceProvider.saveRecord(saveCode: { (object: Interest) in
      object.id = item.id.int64
      object.img = item.img
      object.title = item.title
      object.isSelected = item.isSelected
      object.color = item.color.stringColor
    }, completion: {_ in })
  }
}
