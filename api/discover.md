# Discover

## Discover list

#### Request

###### HTTP Request

```javascript
GET /api/v1/discover
```

###### Request Body

| Name        | Value    | Description             |
| ----------- | -------- | ----------------------- |
| `latitude`  | `string` | required                |
| `longitude` | `string` | required                |
| `radius`    | `string` | optional, default: Xkms |

#### Response

**HTTP/1.1 200 OK**

If successful, this method returns a response body with the following structure:

```javascript
{
  "data": {
    "stories": [
      {
        "id": integer,
        "userId": integer,
        "name": string,
        "description": text,
        "public": boolean,
        "createdAt": datetime,
        "updatedAt": datetime,
        "followed": boolean,
        "storyPoints": [
          {
            "id": integer,
            "userId": integer,
            "storyId": integer,
            "caption": string,
            "public": boolean,
            "kind": string,
            "text": text,
            "address": string,
            "latitude": string,
            "longitude": string,
            "file": string,
            "thumbnail": string,
            "createdAt": datetime,
            "updatedAt": datetime,
            "tags": array,
            "liked": boolean,
            "saved": boolean
          }
        ]
      }
    ],
    "storyPoints": [
      {
        "id": integer,
        "userId": integer,
        "storyId": integer,
        "caption": string,
        "public": boolean,
        "kind": string,
        "text": text,
        "address": string,
        "latitude": string,
        "longitude": string,
        "file": string,
        "thumbnail": string,
        "createdAt": datetime,
        "updatedAt": datetime,
        "tags": array,
        "liked": boolean,
        "saved": boolean
      }
    ]
  }
}
```

###### Response Parameters

| Name          | Value    | Description                       |
| ------------- | -------- | --------------------------------- |
| `stories`     | `array`  | Stories by location               |
| `storyPoints` | `array`  | StoryPoints by location           |

**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "message": "You don't have permission to access"
  }
}
```

---

Discover search

Search by places

#### Request

###### HTTP Request

```javascript
GET /api/v1/search/places
```

###### Request Body

| Name        | Value    | Description             |
| ----------- | -------- | ----------------------- |
| `latitude`  | `string` | required                |
| `longitude` | `string` | required                |
| `radius`    | `string` | optional, default: Xkms |

#### Response

**HTTP/1.1 200 OK**

If successful, this method returns a response body with the following structure:

```javascript
{
  "data": [
    {
      "id": integer,
      "userId": integer,
      "name": string,
      "description": text,
      "public": boolean,
      "createdAt": datetime,
      "updatedAt": datetime,
      "followed": boolean,
      "storyPoints": [
        {
          "id": integer,
          "userId": integer,
          "storyId": integer,
          "caption": string,
          "public": boolean,
          "kind": string,
          "text": text,
          "address": string,
          "latitude": string,
          "longitude": string,
          "file": string,
          "thumbnail": string,
          "createdAt": datetime,
          "updatedAt": datetime,
          "tags": array
        }
      ]
    }
  ]
}
```

###### Response Parameters

| Name          | Value      | Description              |
| ------------- | ---------- | ------------------------ |
| `id`          | `integer`  | Story's id               |
| `userId`      | `integer`  | User's id                |
| `name`        | `string`   | Name                     |
| `description` | `text`     | Description              |
| `public`      | `boolean`  | true/false               |
| `createdAt`   | `datetime` | 2016-02-09T09:23:23.000Z |
| `updatedAt`   | `datetime` | 2016-02-09T09:23:23.000Z |
| `followed`    | `boolean`  | true/false               |
| `storyPoints` | `array`    | Story's SPs              |

**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "message": "You don't have permission to access"
  }
}
```

---
