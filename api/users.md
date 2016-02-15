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
    "personalUrl": string,
    "storyPointsCount": integer,
    "followed": boolean,
    "relationId": integer,
    "createdAt": datetime,
    "updatedAt": datetime
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
|`personalUrl`     | `string` | optional, link to user's personal webpage|
|`storyPointsCount`|`integer`|quantity of sPs created by user|
|`followed`        |`boolean`|true if followed user|
|`relationId`      |`integer`|optional if followed, id of relation object|
|`createdAt`       |`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|
|`updatedAt`       |`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|


**HTTP/1.1 403 Forbidden**

```javascript
{ 
  "error": {
    "errorMessages": [ "You don't have permission to access" ]
  }
}
```

**HTTP/1.1 404  Not Found**

```javascript
{ 
  "error": {
    "errorMessages": [ "Couldn't find User with 'id'=#{:id}" ]
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
    "personalUrl": string,
    "storyPointsCount": integer,
    "followers": integer,
    "following": integer,
    "likes": integer,
    "saves": integer,
    "createdAt": datetime,
    "updatedAt": datetime
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
| `personalUrl`   | `string`   | optional, link to user's personal webpage|
|`storyPointsCount`|`integer`|quantity of sPs created by user|
|`followers`|`integer`|quantity of users subscribers|
|`following`|`integer`|quantity of users subscriptions|
|`likes`|`integer`|how many times other users liked sPs of current users|
|`saved`|`integer`|how many times other users added sPs of current users to their stories|
|`createdAt`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|
|`updatedAt`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|


**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "errorMessages": [ "You don't have permission to access" ]
  }
}
```


**HTTP/1.1 404  Not Found**

```javascript
{
  "error": {
    "errorMessages": [ "Couldn't find User with 'id'=#{:id}" ]
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
  "personalUrl": string,
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
| `personalUrl`   | `string`   | optional, link to user's personal webpage|
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
    "personalUrl": string,
    "avatar": string,
    "home": string,
    "about": text,
    "createdAt": datetime,
    "updatedAt": datetime
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
|`personalUrl`   | `string`   | link to user's personal webpage|
|`avatar`|`string`|path to user's avatar|
|`home`|`string`|user's address|
|`about`|`text`|user's description|
|`createdAt`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|
|`updatedAt`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|

**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "errorMessages": [ "You don't have permission to access" ]
  }
}
```

**HTTP/1.1 404  Not Found**

```javascript
{
  "error": {
    "errorMessages": [ "Couldn't find User with 'id'=#{:id}" ]
  }
}
```

**HTTP/1.1 422  Unprocessable Entity**

```javascript
{
  "error": {
    "errorMessages": array,
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

**Available  `error["errorMessages"]`**:

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
    "errorMessages": [ "You don't have permission to access" ]
  }
}
```

**HTTP/1.1 404  Not Found**

```javascript
{
  "error": {
    "errorMessages": [ "Couldn't find User with 'id'=#{:id}" ]
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
    "errorMessages": [ "You don't have permission to access" ]
  }
}
```

**HTTP/1.1 404  Not Found**

```javascript
{
  "error": {
    "errorMessages": [ "Couldn't find User with 'id'=#{:id}" ]
  }
}
```

**HTTP/1.1 422  Unprocessable Entity**

```javascript
{
  "error": {
    "errorMessages": array,
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

**Available  `error["errorMessages"]`**:

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
  "personalUrl": string,
  "storyPointsCount": integer,
  "followed": boolean,
  "relationId": integer,
  "createdAt": datetime,
  "updatedAt": datetime
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
|`personalUrl`   | `string`   | optional, link to user's personal webpage|
|`storyPointsCount`|`integer`|quantity of sPs created by user|
|`followed`|`boolean`|true if followed user|
|`relationId`|`integer`|optional if followed, id of relation object|
|`createdAt`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|
|`updatedAt`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|

**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "errorMessages": [ "You don't have permission to access" ]
  }
}
```


**HTTP/1.1 404  Not Found**

```javascript
{ 
  "error": {
    "errorMessages": [ "Couldn't find User with 'id'=#{:id}" ]
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
  "personalUrl": string,
  "storyPointsCount": integer,
  "followed": boolean,
  "relationId": integer,
  "createdAt": datetime,
  "updatedAt": datetime
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
|`personalUrl`   | `string`   | optional, link to user's personal webpage|
|`storyPointsCount`|`integer`|quantity of sPs created by user|
|`followed`|`boolean`|true if followed user|
|`relationId`|`integer`|optional if followed, id of relation object|
|`createdAt`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|
|`updatedAt`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|


**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "errorMessages": [ "You don't have permission to access" ]
  }
}
```


**HTTP/1.1 404 Not Found**

```javascript
{
  "error": {
    "errorMessages": [ "Couldn't find User with 'id'=#{:id}" ]
  }
}
```
