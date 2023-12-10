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