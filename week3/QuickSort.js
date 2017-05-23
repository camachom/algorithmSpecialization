function comparisonCount(unsortedArray) {
  let count = 0;

  function QuickSort(array, start = 0, end = array.length - 1) {
    if (start >= end) {
      return;
    }

    count += end - start - 1;
    // let pivot = array[start];
    let borderIdx = subRoutine(array, start, end);
    let leftArray = QuickSort(array, start, borderIdx - 1);
    let rightArray = QuickSort(array, borderIdx + 1, end);

    return array;
  }

  QuickSort(unsortedArray);
  return count;
}


function subRoutine(array, start, end) {
  let i = start;

  for (let x = start + 1; x <= end; x++) {
    if (array[x] < array[start]) {
      // need to swap
      let temp = array[x];
      array[x] = array[i + 1];
      array[i + 1] = temp;
      i++;
    }
  }

  // swap pivot
  let temp = array[start];
  array[start] = array[i];
  array[i] = temp;

  return i;
}

console.log(comparisonCount([100, 89, 76 ,8]));
