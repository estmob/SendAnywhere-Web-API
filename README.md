
# Send Anywhere Web API

## Getting Started
To use the APIs, you need to pass your API key.

### Ways to Pass Your Key:

#### HTTP Header 
Pass the API key into the X-Api-Key header.
```
curl -H 'X-Api-Key: YOUR_API_KEY' 'https://send-anywhere.com/web/v1/device'
```

#### Get Query Parameter 
Pass the API key into the api_key GET query string parameter.
```
curl 'https://send-anywhere.com/web/v1/device?api_key=YOUR_API_KEY'
```

#### HTTP Basic Auth Username 
Pass the API key as the username (without password) using HTTP basic authentication.
```
curl 'https://YOUR_API_KEY@send-anywhere.com/web/v1/device'
```

### Examples
#### Register Device
To use the API, you need to have a unique device_key in your cookie or query parameters.
```
curl -c $COOKIE_FILE "https://send-anywhere.com/web/v1/device?api_key=$API_KEY&profile_name=Send%20Anywhere%20SDK"
```

#### Send Files
To send files, create an 6-digit KEY then you'll get a target link to upload files.

##### Request Sample (with jQuery)
```
$.ajax({url: 'https://send-anywhere.com/web/v1/key',
	type: 'GET',
	dataType: 'jsonp',
	api_key: YOUR_API_KEY
	cache: false
}).done(function (data) {
    // `data.key` is an 6-digit KEY.
    // `data.weblink` is a target link.
});
```

#### Receive files
To receive files, query an 6-digit KEY then you'll get a target link to download files.

##### Request Sample (with jQuery)
```
$.ajax({url: 'https://send-anywhere.com/web/v1/key/123456',
	type: 'GET',
	dataType: 'jsonp',
	api_key: YOUR_API_KEY,
	timeout: 3000,
	cache: false
}).done(function (data) {
	// data.weblink is a target link.
});
```

#### Cross Domain Request
We support JSONP which can be used by passing a callback parameter in the query string of the URL you are requesting.

## Web API Reference
The base URL for API endpoints is:
```
  https://send-anywhere.com
```

### HTTP Response Status
* 200 - OK
* 400 - Bad Request. Invalid request query string.
* 403 - Forbidden. Invalid `api_key`.
* 404 - Not Found. Invalid `key`
* 429 - Too Many Request. To keep the amount of spam on Send Anywhere as low as possible.
* 500 - Internal Server Error. Something went wrong on our side. We're very sorry.

### GET /web/v1/device

Create an unique `device_key` for your client. If `device_key` already exists, just update the device.


Parameters   |                    |
-------------|--------------------|
profile_name | Client device name |

Response Cookies|                    |
----------------|--------------------|
device_key      | Unique device key  |


### GET /web/v1/key

Generate a 6-digit `key` for sending files.

Request Cookies |                   |
----------------|-------------------|
device_key      | Unique device key |

Response |                  |
---------|------------------|
key      | Generated key    |
weblink  | Upload URL       |

##### Response Sample
```
{
  "key":"123456",
  "weblink":"https://file.send-anywhere.com/api/webfile/123456"
}
```

### /web/v1/key/{KEY}

Query a 6-digit `key` for receiving files.

Request Cookies |                   |
----------------|-------------------|
device_key      | Unqiue device key |

Response  |                |
----------|----------------|
key       | Requested key  |
weblink   | Download URL   |

#### Response Sample

```
{
  "key":"123456",
  "weblink":"https://file.send-anywhere.com/api/webfile/123456"
}
```

