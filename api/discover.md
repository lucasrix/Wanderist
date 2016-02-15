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
            "latitude": float,
            "longitude": float,
            "file": string,
            "thumbnail": string,
            "createdAt": datetime,
            "updatedAt": datetime,
            "tags": array,
            "relationId": integer,
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
        "latitude": float,
        "longitude": float,
        "file": string,
        "thumbnail": string,
        "createdAt": datetime,
        "updatedAt": datetime,
        "tags": array,
        "relationId": integer,
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
    "errorMessages": [ "You don't have permission to access" ]
  }
}
```

---

Discover search

Search by places

#### Request

###### HTTP Request

```javascript
GET /api/v1/places
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
        "relationId": integer,
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
            "latitude": float,
            "longitude": float,
            "file": string,
            "thumbnail": string,
            "createdAt": datetime,
            "updatedAt": datetime,
            "tags": array,
            "relationId": integer,
            "saved": boolean,
            "liked": boolean
          }
        ]
      }
    ]
  }
}
```

###### Response Parameters

| Name          | Value    | Description                    |
| ------------- | -------- | ------------------------------ |
| `stories`     | `array`  | Stories by place               |

**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "errorMessages": [ "You don't have permission to access" ]
  }
}
```

---
