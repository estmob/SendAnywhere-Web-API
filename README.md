Send Anywhere Web API
===

### https://send-anywhere.com/web/v1/device
Create device key.

```
https://send-anywhere.com/web/v1/device?api_key={API_KEY}&profile_name={PROFILE_NAME}
```
Parameters   |                     |
-------------|---------------------|
api_key      | Your API key.       |
profile_name | Client device name. |

Return Cookie |                    |
--------------|--------------------|
device_key    | Device unique key. |

Send
---
### https://send-anywhere.com/web/v1/key
Generate key for sending file.

with Cookie|                |
-----------|----------------|
device_key | Device unique key. |

#### HTTP status
* 200
OK
```
{
  "key":"376019",
  "weblink":"https://file.send-anywhere.com/api/webfile/123456"
}
```
Return  |                |
--------|----------------|
key     | Generating key |
weblink | Upload URL     |

* 401
Invalid device key

* 409
Failed to generate key.

Receive
---
### https://send-anywhere.com/web/v1/key/{KEY}
Generate key for sending file.

with Cookie|                |
-----------|----------------|
device_key | Device unique key. |

#### HTTP status
* 200
OK
```
{
  "key":"376019",
  "weblink":"https://file.send-anywhere.com/api/webfile/123456"
}
```
Return  |                |
--------|----------------|
key     | Requested key  |
weblink | Upload URL     |

* 401
Invalid device key

* 404
Invalid key
