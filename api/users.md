# Users

### User Show

#### Request

###### HTTP request

```javascript
GET /api/v1/users/:id
```

###### Request Path

| Name   | Value    | Description    |
| ------ |----------| -------------- |
| `:id`  | `string` | user's  id    |


#### Response

 **HTTP/1.1 200 OK**

```javascript
{
  "data": {
    "id": integer,
    "firstname": string,
    "lastname": string,
    "username": string,
    "avatar": string,
    "home": string,
    "about": text,
    "personal_url": string,
    "story_points_count": integer,
    "followed": boolean,
    "relation_id": integer,
    "created_at": datetime,
    "updated_at": datetime
  }
}
```

###### Response Parameters

| Name             | Value    | Description      |
| -----------------|----------| -----------------|
|`id`              |`integer` |user's id         |
|`firstname`       |`string`  | user's firstname |
|`lastname`        |`string`  |user's lastname   |
|`username`        |`string`  |user's username   |
|`avatar`          |`string`  |path to user's avatar|
|`home`            |`string`  |user's address|
|`about`           |`text`    |user's description|
|`personal_url`     | `string` | optional, link to user's personal webpage|
|`story_points_count`|`integer`|quantity of sPs created by user|
|`followed`        |`boolean`|true if followed user|
|`relation_id`      |`integer`|optional if followed, id of relation object|
|`created_at`       |`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|
|`updated_at`       |`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|


**HTTP/1.1 403 Forbidden**

```javascript
{ 
  "error": {
    "error_messages": [ "You don't have permission to access" ]
  }
}
```

**HTTP/1.1 404  Not Found**

```javascript
{ 
  "error": {
    "error_messages": [ "Couldn't find User with 'id'=#{:id}" ]
  }
}
```

---

### User Profile Show

#### Request

###### HTTP request

```javascript
GET /api/v1/users/:id/profile
```

###### Request Path

| Name   | Value    | Description    |
| ------ |----------| -------------- |
| `:id`  | `string` | user's  id    |


#### Response

**HTTP/1.1 200 OK**

```javascript
{
  "data": {
    "id": integer,
    "firstname": string,
    "lastname": string,
    "username": string,
    "avatar": string,
    "home": string,
    "about": text,
    "personal_url": string,
    "story_points_count": integer,
    "followers": integer,
    "following": integer,
    "likes": integer,
    "saves": integer,
    "created_at": datetime,
    "updated_at": datetime
  }
}
```

###### Response Parameters

| Name         | Value    | Description   |
| ------------ |----------| --------------|
|`id`       |`integer` |user's id |
|`firstname` | `string` | user's firstname |
|`lastname`|`string`|user's lastname|
|`username`|`string`|user's username|
|`avatar`|`string`|path to user's avatar|
|`home`|`string`|user's address|
|`about`|`text`|user's description|
| `personal_url`   | `string`   | optional, link to user's personal webpage|
|`story_points_count`|`integer`|quantity of sPs created by user|
|`followers`|`integer`|quantity of users subscribers|
|`following`|`integer`|quantity of users subscriptions|
|`likes`|`integer`|how many times other users liked sPs of current users|
|`saved`|`integer`|how many times other users added sPs of current users to their stories|
|`created_at`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|
|`updated_at`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|


**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "error_messages": [ "You don't have permission to access" ]
  }
}
```


**HTTP/1.1 404  Not Found**

```javascript
{
  "error": {
    "error_messages": [ "Couldn't find User with 'id'=#{:id}" ]
  }
}
```

---

### Users Profile Update

#### Request

###### HTTP Request

```javascript
PUT /api/v1/users/:id/profile
```

###### Request Path

| Name   | Value    | Description    |
| ------ |----------| -------------- |
| `:id`  | `string` | user's id     |


###### Request Body

```javascript
{
  "username": string,
  "firstname": string,
  "lastname": string,
  "email": string,
  "personal_url": string,
  "home": string,
  "about": text
}
```

| Name           | Value    | Description |
| --------------- |--------- | ----------- |
| `username`  | `string` |optional, user's username   |
| `firstname`   | `string`   | optional, user's firstname |
| `lastname`   | `string`   | optional, user's lastname |
| `email`   | `string`   | optional, user's email|
| `personal_url`   | `string`   | optional, link to user's personal webpage|
| `home`   | `string`   | optional, user's address|
|`about`|`text`|user's description|

#### Response

**HTTP/1.1 200 OK**

```javascript
{
  "data": {
    "id": integer,
    "username": string,
    "firstname": string,
    "lastname": string,
    "email": string,
    "personal_url": string,
    "avatar": string,
    "home": string,
    "about": text,
    "created_at": datetime,
    "updated_at": datetime
  }
}
```

###### Response Parameters

| Name         | Value    | Description   |
| ------------ |----------| --------------|
|`id`       |`integer`|user's id |
|`username`|`string`|user's username|
|`firstname` | `string` | user's firstname |
|`lastname`|`string`|user's lastname|
|`email`|`string`|user's email|
|`personal_url`   | `string`   | link to user's personal webpage|
|`avatar`|`string`|path to user's avatar|
|`home`|`string`|user's address|
|`about`|`text`|user's description|
|`created_at`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|
|`updated_at`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|

**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "error_messages": [ "You don't have permission to access" ]
  }
}
```

**HTTP/1.1 404  Not Found**

```javascript
{
  "error": {
    "error_messages": [ "Couldn't find User with 'id'=#{:id}" ]
  }
}
```

**HTTP/1.1 422  Unprocessable Entity**

```javascript
{
  "error": {
    "error_messages": array,
    "details": object
  }
}
```

###### Response Parameters

**Available  `details["username"]` errors**:

| Name      | Description   |
| ------------| --------------|
|`can't be blank`| if empty username|
|`#{value} has already been taken`| if user with username already exists|

**Available  `details["email"]` errors**:

| Name      | Description   |
| ------------| --------------|
| `can't be blank`| if empty email|
|"#{value} has already been taken"| if user with email already exists

**Available  `error["error_messages"]`**:

Can include all available messages for each field.
Creates from the following rules:
 `field name` +  `errors ["field_message"]`
 For example => Password can't be blank


### Settings Show

```javascript
GET /api/v1/users/:id/settings
```

#### Response

**HTTP/1.1 200 OK**

```javascript
{
  "data": {
    "notifications": boolean,
    "public": boolean
  }
}
```

###### Response Parameters

| Name           | Value    | Description |
| --------------- |--------- | ----------- |
| `notifications`  | `boolean` |receive notifications|
| `public`   | `boolean`   |enybody can view users account and posts|


**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "error_messages": [ "You don't have permission to access" ]
  }
}
```

**HTTP/1.1 404  Not Found**

```javascript
{
  "error": {
    "error_messages": [ "Couldn't find User with 'id'=#{:id}" ]
  }
}
```

---

### Settings Update

#### Request

```javascript
PUT /api/v1/users/:id/settings
```

###### Request Path

| Name   | Value    | Description    |
| ------ |----------| -------------- |
| `:id`  | `string` | User's  id  |

###### Request Body

```javascript
{
  "notifications": boolean,
  "public": boolean
}
```

###### Request Parameters

| Name           | Value    | Description |
| --------------- |--------- | ----------- |
| `notifications`  | `boolean` |required, receive notifications, default: true |
| `public`   | `boolean`   | required, enybody can view users account and posts, default: true |


#### Response

**HTTP/1.1 200 OK**

```javascript
{
  "data": {
    "notifications": boolean,
    "public": boolean
  }
}
```

###### Response Parameters

| Name           | Value    | Description |
| --------------- |--------- | ----------- |
| `notifications`  | `boolean` |receive notifications|
| `public`   | `boolean`   | enybody can view users account and posts|


**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "error_messages": [ "You don't have permission to access" ]
  }
}
```

**HTTP/1.1 404  Not Found**

```javascript
{
  "error": {
    "error_messages": [ "Couldn't find User with 'id'=#{:id}" ]
  }
}
```

**HTTP/1.1 422  Unprocessable Entity**

```javascript
{
  "error": {
    "error_messages": array,
    "details": object
  }
}
```

###### Response Parameters

**Available fields error["details"]**:

| Name         | Value    | Description   |
| ------------ |----------| --------------|
| `details["notifications"]`| `array` | "can't be blank"
| `details["public"]`| `array` | "can't be blank"

**Available  `error["error_messages"]`**:

Can include all available messages for each field.
Creates from the following rules:
`field name` + `errors["field_message"]`
For example => Password can't be blank

---

### Followers

#### Request

```javascript
GET /api/v1/users/:id/followers
```

###### Request Path

| Name   | Value    | Description    |
| ------ |----------| -------------- |
| `:id`  | `string` | user's  id  |

#### Response

**HTTP/1.1 200 OK**

```javascript
{
  "data": {
    "followers": array
  }
}
```

###### Response Parameters

| Name           | Value    | Description |
| --------------- |--------- | ----------- |
| `followers`  | `array` |array of followers|

###### Element of followers array

```javascript
{
  "id": integer,
  "firstname": string,
  "lastname": string,
  "username": string,
  "avatar": string,
  "home": string,
  "about": text,
  "personal_url": string,
  "story_points_count": integer,
  "followed": boolean,
  "relation_id": integer,
  "created_at": datetime,
  "updated_at": datetime
}
```

###### Response Parameters

| Name         | Value    | Description   |
| ------------ |----------| --------------|
|`id`       |`integer` |user's id |
|`firstname` | `string` | user's firstname |
|`lastname`|`string`|user's lastname|
|`username`|`string`|user's username|
|`avatar`|`string`|path to user's avatar|
|`home`|`string`|user's address|
|`about`|`text`|user's description|
|`personal_url`   | `string`   | optional, link to user's personal webpage|
|`story_points_count`|`integer`|quantity of sPs created by user|
|`followed`|`boolean`|true if followed user|
|`relation_id`|`integer`|optional if followed, id of relation object|
|`created_at`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|
|`updated_at`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|

**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "error_messages": [ "You don't have permission to access" ]
  }
}
```


**HTTP/1.1 404  Not Found**

```javascript
{ 
  "error": {
    "error_messages": [ "Couldn't find User with 'id'=#{:id}" ]
  }
}
```

---

### Following

#### Request

```javascript
GET /api/v1/users/:id/followings
```

###### Request Path

| Name   | Value    | Description    |
| ------ |----------| -------------- |
| `:id`  | `string` | user's  id  |


#### Response

**HTTP/1.1 200 OK**

```javascript
{
  "data": {
    "followings": array
  }
}
```

###### Response Parameters

| Name           | Value    | Description |
| --------------- |--------- | ----------- |
| `followings`  | `array` |array of followings|

###### Element of followings array

```javascript
{
  "id": integer,
  "firstname": string,
  "lastname": string,
  "username": string,
  "avatar": string,
  "home": string,
  "about": text,
  "personal_url": string,
  "story_points_count": integer,
  "followed": boolean,
  "relation_id": integer,
  "created_at": datetime,
  "updated_at": datetime
}
```

###### Parameters

| Name         | Value    | Description   |
| ------------ |----------| --------------|
|`id`       |`integer` |user's id |
|`firstname` | `string` | user's firstname |
|`lastname`|`string`|user's lastname|
|`username`|`string`|user's username|
|`avatar`|`string`|path to user's avatar|
|`home`|`string`|user's address|
|`about`|`text`|user's description|
|`personal_url`   | `string`   | optional, link to user's personal webpage|
|`story_points_count`|`integer`|quantity of sPs created by user|
|`followed`|`boolean`|true if followed user|
|`relation_id`|`integer`|optional if followed, id of relation object|
|`created_at`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|
|`updated_at`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|


**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "error_messages": [ "You don't have permission to access" ]
  }
}
```


**HTTP/1.1 404 Not Found**

```javascript
{
  "error": {
    "error_messages": [ "Couldn't find User with 'id'=#{:id}" ]
  }
}
```
