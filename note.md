## 任务
+ Git学习：Usage of Git
+ 熟悉现有 java 和 vue 代码；
+ 学习RESTful 风格的 http 接口：https://www.ruanyifeng.com/blog/2014/05/restful_api.html
+ 需要访问 localhost:8080/home 时，出现主页；学习一下 vue 的知识:https://cn.vuejs.org/，结合 ai
+ 当登录完成后，自动跳转到 /home
    - vue 的 router
    - home页面压缩包，见附件。

# Vue
## axios
+ axios是目前前端最常用的发送网络请求的工具
+ axios需单独安装（npm install axios），并非Vue自带，安装后需引入才能使用
+ Vue2中可通过`Vue.prototype.$axios = axios`全局挂载，所有组件可直接用`this.$axios`发送请求（GET/POST等）

## vue-router
### 核心定义
vue-router 是 Vue.js 官方配套的**路由管理器**，专门用于实现单页面应用（SPA）的页面切换，核心特点是「不刷新整个网页，只切换局部内容」，避免页面跳转时的刷新延迟，提升用户体验。

vue-router 需单独安装，并非 Vue2 自带，且需在 Vue 实例中注入后才能使用。

### 核心组件与用法

#### 1. <router-view />（页面容器）

- 作用：作为路由对应页面的「占位符/容器」，所有匹配当前路由的页面组件，都会渲染到这个标签所在的位置。

- 常用场景：一般放在 App.vue（根组件）中，作为整个应用所有页面的统一展示区域。

- 补充：页面切换时，本质是替换 <router-view /> 内渲染的组件，整个页面其他部分（如导航栏）不变。

#### 2. <router-link to="路径">（路由跳转标签）

- 作用：替代原生\<a>标签，实现路由跳转，**不会刷新页面**（核心优势）。

- 基础用法：<router-link to="/home">首页</router-link>

- 关键属性：

  - to：指定跳转的路由路径（必填），可写字符串（如 "/home"）或对象（如 { path: "/user", query: { id: 1 } }）。

  - replace：添加 replace 属性后，跳转不会留下浏览器历史记录，后退无法回到上一页（如 <router-link to="/login" replace>登录</router-link>）。

#### 3. 编程式导航（JS 跳转，常用）

- 作用：在 JS 代码中实现路由跳转（如登录成功后跳转、按钮点击跳转），核心是使用 this.$router 对象。

- 常用方法：

  - this.$router.push("路径/对象")：最常用，跳转后留下历史记录（可后退），例：this.$router.push("/home")、this.$router.push({ path: "/user", params: { id: 123 } })。

  - this.$router.replace("路径")：跳转后不留下历史记录，例：this.$router.replace("/login")。

  - this.$router.go(n)：前进/后退页面，n 为数字（正数前进，负数后退），例：this.$router.go(-1)（后退一页）。

## 其他知识
### **DOM**
DOM 就是把 HTML 里的标签、元素、文本，变成一个个 JS 可以读写、修改的对象。
### **Vue SPA**
+ SPA = Single Page Application，单页面应用
+ 整个项目只有一个 HTML 页面，切换页面时不刷新浏览器，只通过 JS 动态替换页面内容，看起来像多页面，其实一直是同一个页面。
---
# SpringBoot
+ 目的：更方便地复用部分可以在多个项目中重复使用的工具类等
+ SpringBoot项目的依赖管理工具：Maven
+ 初始化SpringBoot项目：https://start.spring.io/
+ 

# RESTful API
## http
+ 定义：http超文本传输协议是用于客户端和服务器之间传输超文本（如html）的协议，定义了客户端如何向服务器端发送请求以及服务器如何向客户端响应这些请求。
+ 标准http方法：GET/HEAD/POST/PUT/DELETE/PATCH/OPTIONS/CONNECT/TRACE

我来为你系统整理RESTful风格API的完整知识体系：

---

## 一、RESTful 核心概念

### 1. 什么是REST
**REST**（Representational State Transfer，表述性状态转移）是由Roy Fielding在2000年博士论文中提出的架构风格，不是协议或标准，而是一组设计约束和原则。

### 2. 核心原则

| 原则 | 说明 |
|------|------|
| **无状态（Stateless）** | 每个请求独立，服务器不保存客户端状态 |
| **统一接口（Uniform Interface）** | 使用标准HTTP方法操作资源 |
| **可缓存（Cacheable）** | 响应可被客户端或中间层缓存 |
| **分层系统（Layered System）** | 客户端无需知道是否直接连接服务器 |
| **按需代码（Code on Demand）** | 服务器可传输可执行代码（可选） |

---

## 二、资源（Resources）设计

### 1. 资源命名规范
```
✅ 正确示例：
GET    /users              # 获取用户列表
GET    /users/123          # 获取ID为123的用户
GET    /users/123/orders   # 获取用户123的订单
POST   /users              # 创建用户
PUT    /users/123          # 更新用户123
DELETE /users/123          # 删除用户123

❌ 错误示例：
GET    /getUsers           # 动作不应在URL中
GET    /user/getById       # 冗余路径
POST   /users/createUser   # 重复语义
```

### 2. 命名规则
- **使用名词复数**：`/users` 而非 `/user`
- **小写字母**：`/user-profiles` 而非 `/UserProfiles`
- **连字符分隔**：`/user-profiles` 而非 `/user_profiles` 或 `/userProfiles`
- **避免动词**：用HTTP方法表达动作

---

## 三、HTTP方法（Methods）

| 方法 | 幂等性 | 安全性 | 用途 |
|------|--------|--------|------|
| **GET** | ✓ | ✓ | 获取资源 |
| **POST** | ✗ | ✗ | 创建资源 |
| **PUT** | ✓ | ✗ | 全量更新资源 |
| **PATCH** | ✗ | ✗ | 局部更新资源 |
| **DELETE** | ✓ | ✗ | 删除资源 |
| **HEAD** | ✓ | ✓ | 获取响应头 |
| **OPTIONS** | ✓ | ✓ | 获取支持的方法 |

> **幂等性**：多次相同请求结果一致  
> **安全性**：不改变服务器状态

---

## 四、状态码（Status Codes）

### 2xx 成功
| 码 | 含义 | 场景 |
|----|------|------|
| 200 | OK | 通用成功 |
| 201 | Created | 资源创建成功 |
| 204 | No Content | 删除成功，无返回体 |

### 3xx 重定向
| 码 | 含义 |
|----|------|
| 301 | 永久重定向 |
| 304 | 未修改（缓存有效） |

### 4xx 客户端错误
| 码 | 含义 | 场景 |
|----|------|------|
| 400 | Bad Request | 请求参数错误 |
| 401 | Unauthorized | 未认证 |
| 403 | Forbidden | 无权限 |
| 404 | Not Found | 资源不存在 |
| 409 | Conflict | 资源冲突（如重复创建） |
| 422 | Unprocessable Entity | 语义错误（如验证失败） |

### 5xx 服务器错误
| 码 | 含义 |
|----|------|
| 500 | Internal Server Error |
| 502 | Bad Gateway |
| 503 | Service Unavailable |

---

## 五、请求与响应设计

### 1. 请求设计

**查询参数（Query Parameters）**
```
GET /users?status=active&page=1&limit=20&sort=-created_at
```

常用查询参数模式：
| 参数 | 用途 |
|------|------|
| `?fields=name,email` | 字段过滤 |
| `?expand=orders` | 关联资源展开 |
| `?page=1&limit=20` | 分页（Limit/Offset） |
| `?cursor=xxx` | 游标分页 |
| `?sort=-created_at` | 排序（-表示降序） |
| `?q=keyword` | 全文搜索 |

**请求体格式**
```json
// POST /users
{
  "name": "张三",
  "email": "zhangsan@example.com",
  "role": "user"
}
```

### 2. 响应设计

**成功响应结构**
```json
// GET /users/123
{
  "id": "123",
  "name": "张三",
  "email": "zhangsan@example.com",
  "created_at": "2024-01-15T08:30:00Z",
  "_links": {
    "self": "/users/123",
    "orders": "/users/123/orders"
  }
}

// GET /users（集合）
{
  "data": [
    { "id": "123", "name": "张三" },
    { "id": "124", "name": "李四" }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 150,
    "total_pages": 8
  },
  "_links": {
    "self": "/users?page=1",
    "next": "/users?page=2",
    "last": "/users?page=8"
  }
}
```

**错误响应结构（RFC 7807 - Problem Details）**
```json
{
  "type": "https://api.example.com/errors/invalid-params",
  "title": "Invalid Request Parameters",
  "status": 400,
  "detail": "One or more parameters are invalid",
  "instance": "/users",
  "errors": [
    { "field": "email", "message": "Invalid email format" }
  ]
}
```

---

## 六、版本控制策略

| 策略 | 示例 | 优缺点 |
|------|------|--------|
| **URL路径** | `/v1/users`, `/v2/users` | 直观，但破坏REST"资源不变"原则 |
| **请求头** | `Accept: application/vnd.api.v1+json` | 干净，但不够直观 |
| **自定义头** | `API-Version: 1` | 灵活，需文档说明 |
| **查询参数** | `/users?version=1` | 简单，易缓存问题 |

**推荐**：URL路径版本控制，最简单实用
```
/api/v1/users
/api/v2/users
```

---

## 七、认证与授权

### 常见认证方式

| 方式 | 适用场景 |
|------|----------|
| **API Key** | 简单场景，服务器间通信 |
| **Bearer Token (JWT)** | 无状态认证，移动端/Web |
| **OAuth 2.0** | 第三方授权，社交登录 |
| **HMAC** | 高安全性，签名验证 |

**请求头示例**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIs...
// 或
X-API-Key: your-api-key-here
```

---


+ 定义：REST是一种软件架构风格，让客户端和服务器以无状态的方式互相传递资源的表现层数据来查询或者变更资源状态
---
# Linux
+ 查看项目的代码结构
```bash
cloc .
```
