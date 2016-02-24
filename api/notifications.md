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
      "user_id": integer,
      "kind": string,
      "entity": string,
      "entity_id": integer,
      "read_at": datetime,
      "created_at": datetime,
      "updated_at": datetime
    }
  ]
}
```

###### Response Parameters

| Name        | Value      | Description                       |
| ----------- | ---------- | --------------------------------- |
| `id`        | `integer`  | Notify's id                       |
| `user_id`    | `integer`  | User's id                         |
| `kind`      | `string`   | "saved", "followed", "liked", ""  |
| `entity`    | `string`   | Entity type                       |
| `entity_id`  | `integer`  | Entity's id                       |
| `readAt`    | `datetime` | "2016-02-09T09:23:23.000Z"        |
| `created_at` | `datetime` | "2016-02-09T09:23:23.000Z"        |
| `updated_at` | `datetime` | "2016-02-09T09:23:23.000Z"        |

**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "error_messages": [ "You don't have permission to access" ]
  }
}
```

---
