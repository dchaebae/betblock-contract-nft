const words = args[0];

if (!secrets.apiKey) {
  throw Error(
    'Need betblock key!'
  );
}

// build HTTP request object
const apiRequest = Functions.makeHttpRequest({
  url: `https://api.betblock.fi/validateKey`,
  headers: {
    "x-api-key": secrets.apiKey,
  },
  params: {
    words: '',
  },
});

// Make the HTTP request
const apiResponse = await apiRequest;
console.log(apiResponse)

if (apiResponse.error) {
  throw new Error("Response Error");
}

// fetch the price
const val = apiResponse.data;

console.log(val);
return Functions.encodeString(val)
// price * 100 to move by 2 decimals (Solidity doesn't support decimals)
// Math.round() to round to the nearest integer
// Functions.encodeUint256() helper function to encode the result from uint256 to bytes
//return Functions.encodeUint256(Math.round(price * 100));