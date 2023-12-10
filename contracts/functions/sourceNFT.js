// This functions get details about Star Wars characters. This example will showcase usage of HTTP requests and console.logs.
// 1, 2, 3 etc.
// Execute the API request (Promise)
const apiResponse = await Functions.makeHttpRequest({
  url: `https://swapi.dev/api/people/1/`
})

if (apiResponse.error) {
  console.error(apiResponse.error)
  throw Error("Request failed")
}

const { data } = apiResponse;

console.log('API response data:', JSON.stringify(data, null, 2));
console.log(data.name)
// Return Character Name
return Functions.encodeString(data.name)
