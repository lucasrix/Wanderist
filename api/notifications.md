# Notifications

## Get User's notifications

#### Request

###### HTTP Request

```javascript
GET /api/v1/notifications
```

#### Response

**HTTP/1.1 200 OK**

If successful, this method returns a response body with the following structure:

```javascript
{
  "data": [
    {
      "id": integer,
      "userId": integer,
      "kind": string,
      "entity": string,
      "entityId": integer,
      "readAt": datetime,
      "createdAt": datetime,
      "updatedAt": datetime
    }
  ]
}
```

###### Response Parameters

| Name        | Value      | Description                       |
| ----------- | ---------- | --------------------------------- |
| `id`        | `integer`  | Notify's id                       |
| `userId`    | `integer`  | User's id                         |
| `kind`      | `string`   | "saved", "followed", "liked", ""  |
| `entity`    | `string`   | Entity type                       |
| `entityId`  | `integer`  | Entity's id                       |
| `readAt`    | `datetime` | "2016-02-09T09:23:23.000Z"        |
| `createdAt` | `datetime` | "2016-02-09T09:23:23.000Z"        |
| `updatedAt` | `datetime` | "2016-02-09T09:23:23.000Z"        |

**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "message": "You don't have permission to access"
  }
}
```

---
