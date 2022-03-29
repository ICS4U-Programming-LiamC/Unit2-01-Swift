//
//  satudentMarks.swift
//
//  Created by Liam Csiffary
//  Created on 2022-03-24
//  Version 1.0
//  Copyright (c) 2022 IMH. All rights reserved.
//
// The String reverser program takes a txt file of
// various strings and flips them around
// then it puts those strings into a new txt file

import Foundation

// reads the txt file
// code from
// https://forums.swift.org/t/read-text-file-line-by-line/28852/4
func readFile(_ path: String) -> [String] {
  var arrayOfStrings: [String] = []
  errno = 0
  if freopen(path, "r", stdin) == nil {
    perror(path)
    return []
  }
  while let line = readLine() {
    arrayOfStrings.append(String(line))
    //do something with lines..
  }
  return arrayOfStrings
}

func writeTxt(from recArray:[String]) {

  // turns the contents of the array into a string
  var str = ""
  for string in recArray {
    str += string + "\n"
  }

  // https://stackoverflow.com/questions/55870174/how-to-create-a-csv-file-using-swift
  let filePath = NSHomeDirectory() + "/stringReverser/Unit2-01-Swift/reversedStrings.txt"
  
  if (FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil)) {
    print("File created successfully.")
  } else {
    print("File not created.")
  }

  // https://stackoverflow.com/questions/24410473/how-to-convert-this-var-string-to-url-in-swift
  let filename = URL(fileURLWithPath: filePath)
  print(filename)

  // https://www.hackingwithswift.com/example-code/strings/how-to-save-a-string-to-a-file-on-disk-with-writeto
  do {
    try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
  } catch {
    // failed to write file - bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
    print("failed")
  }  
}

// the reverser function
func Reverser(str: String) -> String {
  // while the string is not empty
  if (str != "") {
    // calls the function again and passes it
    // the string excluding the first letter
    // it takes the length - 1 and counts from the end
    // to the front, then adds the first char at the end
    return Reverser(str: String(str.suffix(str.count - 1))) + String(str.prefix(1))

  // if it is empty return the empty string
  } else  {
    return str;

  }
}

// main, defines the file location and
// calls the other functions
func main() {
  let file = "testCases.txt"
  let testStrings: [String] = readFile(file)

  // gets the reversed string for each of the test
  // strings in testStrings[]
  var reversedStrings: [String] = []
  for (i, _) in testStrings.enumerated() {
    let reversedString = Reverser(str: testStrings[i])
    reversedStrings.append(reversedString)
  }

  // prints each one, its more convinient to read like this
  // as opposed to opneing the txt file each time
  print("")
  for (i, each) in reversedStrings.enumerated() {
    print("Original string: " + testStrings[i])
    print("Reversed String: " + each + "\n")
  }
  writeTxt(from: reversedStrings)
}

main()
