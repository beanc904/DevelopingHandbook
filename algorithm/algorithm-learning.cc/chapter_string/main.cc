//
// Created by coffee-bean on 2025/8/29.
//

#include <fmt/core.h>
#include <string>

int main(int argc, char* argv[]) {
  // ANCHOR: init string
  // 1. declare string
  std::string str_empty;

  // 2. initialize string
  std::string str = "Hello, World!";
  fmt::print("str: {}\n", str);
  // ANCHOR_END: init string

  // ANCHOR: common member function
  // 1. size() - get the size of the string
  //    length() - the old function to get the size, same to size()
  auto size = str.size();
  auto len = str.length();
  fmt::print("The size of the str: {}.\n", size);
  fmt::print("The length of the str: {}.\n", len);

  // 2. empty() - check if the string is empty
  auto is_empty = str_empty.empty();
  fmt::print("If the str_empty is empty: {}.\n", is_empty);

  // 3. operator[] - visit the char through index without bounds checking
  //    at() - visit the char through index with bounds checking
  auto c8 = str[7];
  auto c_at8 = str.at(7);
  fmt::print("The content of c8: {}.\n", c8);
  fmt::print("The content of c_at8: {}.\n", c_at8);

  // 4. substr() - get the sub string
  auto sub_str = str.substr(0, 5);
  fmt::print("The content of sub_str: {}.\n", sub_str);

  // 5. find() - find the location of the substr in the main str, from the start
  //    rfind() - find the location of the substr, from the end
  std::string str_f = "This is a string.";
  auto location = str_f.find("is");
  auto rlocation = str_f.rfind("is");
  fmt::print("The location of 'is' in str_f is: {}.\n", location);
  fmt::print("The rlocation of 'is' in str_f is: {}.\n", rlocation);

  // 6. replace() - replace some substr inside the main string
  // the origin string is the same to the return of replace()
  auto ref_str = str.replace(7, 5, "CoffeeBean");
  fmt::print("The content of the origin str: {}.\n", str);
  fmt::print("The content of ref_str: {}.\n", ref_str);
  // ANCHOR_END: common member function

  // ANCHOR: the other useful member function

  // ANCHOR_END: the other useful member function
  return 0;
}