function recMult(firstNum, secNum) {
  if (firstNum < 10 || secNum < 10) {
    return firstNum * secNum;
  }

  ({firstDigits, secondDigits} = addPadding(Number(firstNum).toString(),
    Number(secNum).toString()));

  const n = Math.max(firstDigits.length, secondDigits.length);
  const midIdx = Math.floor(n / 2);

  const a = parseInt(firstDigits.slice(0, midIdx));
  const b = parseInt(firstDigits.slice(midIdx));
  const c = parseInt(secondDigits.slice(0, midIdx));
  const d = parseInt(secondDigits.slice(midIdx));

  const ac = recMult(a,c);
  const bd = recMult(b,d);

  const adPlusbc = recMult((+a + +b), (+c + +d));

  return (Math.pow(10, n) * ac)
    + ((Math.pow(10, n / 2) * (adPlusbc - ac - bd)) + bd);
}

function addPadding(firstDigits, secondDigits) {
  let max, min;
  if (firstDigits.length > secondDigits.length) {
    max = firstDigits;
    min = secondDigits;
  }
  else {
    max = secondDigits;
    min = firstDigits;
  }

  if (max.length % 2 !== 0) {
    max = "0" + max;
  }

  if (min.length < max.length) {
    let diff = max.length - min.length;
    const padding = new Array(diff + 1).join("0");
    min = padding + min;
  }

  return {firstDigits: max, secondDigits: min};
}
