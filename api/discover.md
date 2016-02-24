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
        "user_id": integer,
        "name": string,
        "description": text,
        "public": boolean,
        "created_at": datetime,
        "updated_at": datetime,
        "followed": boolean,
        "story_points": [
          {
            "id": integer,
            "user_id": integer,
            "story_id": integer,
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
| `story_points` | `array`  | StoryPoints by location           |

**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "error_messages": [ "You don't have permission to access" ]
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
        "user_id": integer,
        "name": string,
        "description": text,
        "public": boolean,
        "created_at": datetime,
        "updated_at": datetime,
        "followed": boolean,
        "relation_id": integer,
        "storyPoints": [
          {
            "id": integer,
            "user_id": integer,
            "story_id": integer,
            "caption": string,
            "public": boolean,
            "kind": string,
            "text": text,
            "address": string,
            "latitude": float,
            "longitude": float,
            "file": string,
            "thumbnail": string,
            "created_at": datetime,
            "updated_at": datetime,
            "tags": array,
            "relation_id": integer,
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
    "error_messages": [ "You don't have permission to access" ]
  }
}
```

---
