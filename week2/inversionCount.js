function countInversions(input) {

  let tally = 0;
  mergeSort(input);
  return tally;

  function mergeSort(array) {
    if (array.length <= 1) {
      return array;
    }

    const midIdx = Math.floor(array.length / 2);
    const left = mergeSort(array.slice(0, midIdx));
    const right = mergeSort(array.slice(midIdx));

    return merge(left, right);
  }

  function merge(left, right) {
    let sortedArray = [];

    while (left.length > 0 && right.length > 0) {
      if (left[0] < right[0]) {
        sortedArray.push(left.shift());
      }
      else if (left[0] > right[0]) {
        sortedArray.push(right.shift());
        tally += left.length;
      }
      // supposing distinct elements
    }
    sortedArray = sortedArray.concat(left,right);
    return sortedArray;
  }
}
