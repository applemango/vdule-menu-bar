//
//  quicksort.swift
//  vdule
//
//  Created by apple on 2024/02/10.
//

import Foundation

/*
 * Gemini Pro
 */
/*func quickSort<T>(arr: [T], fn: (T, T) -> Bool) -> [T] {
  guard arr.count > 1 else { return arr }
  
  let pivot = arr[arr.count / 2]
  var left = [T]()
  var right = [T]()
  
  for element in arr {
    if fn(element, pivot) {
      left.append(element)
    } else if fn(pivot, element) {
      right.append(element)
    }
  }
  
    return quickSort(arr: left, fn: fn) + [pivot] + quickSort(arr: right, fn: fn)
}*/


/*
 * Bing Chat
 * なんかこうやってaiに書かせるの効率悪いことに気がついた、普通に自分で書いた方が何倍も早い、やっぱaiはクソだわ、バグあるし
 * # warning
 * a <= bとかの場合無限ループに陥る
 */
func quickSort<T>(arr: [T], fn: (T, T) -> Bool) -> [T] {
    guard arr.count > 1 else { return arr }

    let pivot = arr[arr.count / 2]
    var left = [T]()
    var middle = [T]()
    var right = [T]()

    for element in arr {
        if fn(element, pivot) {
            left.append(element)
        } else if fn(pivot, element) {
            right.append(element)
        } else {
            middle.append(element)
        }
    }
    return quickSort(arr: left, fn: fn) + middle + quickSort(arr: right, fn: fn)
}


