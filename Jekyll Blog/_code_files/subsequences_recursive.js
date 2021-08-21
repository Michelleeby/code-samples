function numDistinct(s, t) {
  function countDistinct(source, target) {
    // Base Cases
    if (target < 0) { return 1 } // Subsequence to all.
    if (source < 0) { return 0 } // Cannot have a subsequence.
    // Recursive Cases
    if (s.charAt(source) != t.charAt(target)) { 
      return countDistinct(source - 1, target)
    } else { 
      // Char at target is either:
      // A. part of a subsequence or 
      // B. not part of a subsequence.
      // Return the sum of both options.
      return countDistinct(source - 1, target - 1) 
            + countDistinct(source - 1, target)
    }
  }
  return countDistinct(s.length - 1, t.length - 1)
}
