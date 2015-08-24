Send Anywhere Web API
===

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

