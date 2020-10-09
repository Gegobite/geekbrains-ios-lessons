//
//  ArrayExtensions.swift
//  SocialApp
//
//  Created by Игорь Ершов on 07.10.2020.
//

import Foundation

extension Array<TEntity>{
    func select<TResult>(predicate: (TEntity) -> TResult) -> [TResult] {
            var array = [TResult]()
            for element in self {
                array.append(predicate(element))
            }
            return array
        }
}
