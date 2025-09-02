//
// Created by coffee-bean on 2025/8/29.
//

#include <fmt/ranges.h>
#include <algorithm>
#include <vector>

int main(int argc, char* argv[]) {
  std::vector<int> v = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
  std::sort(v.begin(), v.end());
  fmt::print("std::sort: {}\n", v);

  return 0;
}
