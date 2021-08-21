function subsets(set) {
  function buildSubsets(subset) {
    // Base Case
    if (subset.length < 1) { return [ [] ] }
    // Recursive Case
    return [subset].concat(buildSubsets(subset.slice(0, -1)
    .concat(rest(set, subset.slice(-1).pop()))))
  }
  return buildSubsets(set)
}
/**
 * @param {array} set An array of non repeating integers.
 * @param {number} element The element to slice set from.
 * @return {array} The given set sliced from the given element.
 */
function rest(set, element) {
  let el = set.indexOf(element) + 1;
  return set.slice(el)
}