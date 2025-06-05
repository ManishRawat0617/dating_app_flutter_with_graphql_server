Restarting '.\\server.js'
🚀 Server running at http://localhost:4000/graphql
MongoDB connected successfully
 PostgreSQL Database connected successfully
Tables created successfully.
authHeader

{
  req: PonyfillRequest {
    bodyInit: IncomingMessage {
      _events: [Object],
      _readableState: [ReadableState],
      _maxListeners: undefined,
      socket: [Socket],
      httpVersionMajor: 1,
      httpVersionMinor: 1,
      httpVersion: '1.1',
      complete: true,
      rawHeaders: [Array],
      rawTrailers: [],
      joinDuplicateHeaders: null,
      aborted: false,
      upgrade: false,
      url: '/',
      method: 'POST',
      statusCode: null,
      statusMessage: null,
      client: [Socket],
      _consuming: true,
      _dumped: false,
      res: [ServerResponse],
      next: [Function: next],
      baseUrl: '/graphql',
      originalUrl: '/graphql',
      _parsedUrl: [Url],
      params: [Object: null prototype] {},
      _eventsCount: 4,
      [Symbol(shapeMode)]: true,
      [Symbol(kCapture)]: false,
      [Symbol(kHeaders)]: [Object],
      [Symbol(kHeadersCount)]: 34,
      [Symbol(kTrailers)]: null,
      [Symbol(kTrailersCount)]: 0
    },
    options: {
      method: 'POST',
      headers: [Object],
      signal: [AbortSignal],
      body: [IncomingMessage],
      duplex: 'half'
    },
    bodyUsed: false,
    contentType: 'application/json',
    contentLength: 207,
    signal: AbortSignal { aborted: false },
    bodyType: 'Readable',
    _bodyFactory: [Function: bodyFactory],
    _generatedBody: PonyfillReadableStream {
      readable: [PassThrough],
      locked: false,
      [Symbol(Symbol.toStringTag)]: 'ReadableStream'
    },
    _buffer: <Buffer 7b 22 71 75 65 72 79 22 3a 22 6d 75 74 61 74 69 6f 6e 20 75 70 64 61 74 65 55 73 65 72 28 24 69 64 3a 49 44 21 24 65 6d 61 69 6c 3a 53 74 72 69 6e 67 ... 157 more bytes>,
    _chunks: [
      <Buffer 7b 22 71 75 65 72 79 22 3a 22 6d 75 74 61 74 69 6f 6e 20 75 70 64 61 74 65 55 73 65 72 28 24 69 64 3a 49 44 21 24 65 6d 61 69 6c 3a 53 74 72 69 6e 67 ... 157 more bytes>
    ],
    _blob: null,
    _formData: null,
    _json: {
      query: 'mutation updateUser($id:ID!$email:String!){updateUser(email:$email id:$id){id email}}',
      variables: [Object],
      operationName: 'updateUser'
    },
    _text: '{"query":"mutation updateUser($id:ID!$email:String!){updateUser(email:$email id:$id){id email}}","variables":{"id":"96e2dac1-4882-4cf9-9771-e3718b2a7513","email":"manish@m.com"},"operationName":"updateUser"}',
    headersSerializer: undefined,
    cache: 'default',
    credentials: 'same-origin',
    destination: 'document',
    headers: Headers {
      host: 'localhost:4000',
      connection: 'keep-alive',
      'content-length': '207',
      'sec-ch-ua-platform': '"Windows"',
      authorization: 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijk2ZTJkYWMxLTQ4ODItNGNmOS05NzcxLWUzNzE4YjJhNzUxMyIsImVtYWlsIjoibWFuaXNoQG0uY29tIiwiaWF0IjoxNzQ3NzEyODg0LCJleHAiOjE3NDc3MTY0ODR9.yNW9dUPJpKp42L4RRPVzxCgKAVUJsN96_gDyDZy3j_E',
      'user-agent': [
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML',
        'like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0'
      ],
      accept: [
        'application/graphql-response+json',
        'application/json',
        'multipart/mixed'
      ],
      'sec-ch-ua': [
        '"Chromium";v="136"',
        '"Microsoft Edge";v="136"',
        '"Not.A/Brand";v="99"'
      ],
      'content-type': 'application/json',
      'sec-ch-ua-mobile': '?0',
      origin: 'http://localhost:4000',
      'sec-fetch-site': 'same-origin',
      'sec-fetch-mode': 'cors',
      'sec-fetch-dest': 'empty',
      referer: 'http://localhost:4000/graphql?query=mutation+updateUser%28%24id%3AID%21%2C%24email%3A+String%21%29+%7B%0A++updateUser%28email%3A+%24email%2Cid%3A%24id%29+%7B%0A+++%0A+++id+%0A++++email%0A++%7D%0A%7D%0A',
      'accept-encoding': [ 'gzip', 'deflate', 'br', 'zstd' ],
      'accept-language': [ 'en-US', 'en;q=0.9' ]
    },
    integrity: '',
    keepalive: false,
    method: 'POST',
    mode: 'cors',
    priority: 'auto',
    redirect: 'follow',
    referrer: 'about:client',
    referrerPolicy: 'no-referrer',
    _url: 'http://localhost:4000/graphql',
    _parsedUrl: URL {
      href: 'http://localhost:4000/graphql',
      origin: 'http://localhost:4000',
      protocol: 'http:',
      username: '',
      password: '',
      host: 'localhost:4000',
      hostname: 'localhost',
      port: '4000',
      pathname: '/graphql',
      search: '',
      searchParams: URLSearchParams {},
      hash: ''
    },
    duplex: 'half',
    agent: undefined,
    [Symbol(Symbol.toStringTag)]: 'Request'
  },
  res: <ref *1> ServerResponse {
    _events: [Object: null prototype] {
      finish: [Array],
      error: [Function],
      close: [Function]
    },
    _eventsCount: 3,
    _maxListeners: undefined,
    outputData: [],
    outputSize: 0,
    writable: true,
    destroyed: false,
    _last: false,
    chunkedEncoding: false,
    shouldKeepAlive: true,
    maxRequestsOnConnectionReached: false,
    _defaultKeepAlive: true,
    useChunkedEncodingByDefault: true,
    sendDate: true,
    _removedConnection: false,
    _removedContLen: false,
    _removedTE: false,
    strictContentLength: false,
    _contentLength: null,
    _hasBody: true,
    _trailer: '',
    finished: false,
    _headerSent: false,
    _closed: false,
    socket: Socket {
      connecting: false,
      _hadError: false,
      _parent: null,
      _host: null,
      _closeAfterHandlingError: false,
      _events: [Object],
      _readableState: [ReadableState],
      _writableState: [WritableState],
      allowHalfOpen: true,
      _maxListeners: undefined,
      _eventsCount: 8,
      _sockname: null,
      _pendingData: null,
      _pendingEncoding: '',
      server: [Server],
      _server: [Server],
      parser: [HTTPParser],
      on: [Function: socketListenerWrap],
      addListener: [Function: socketListenerWrap],
      prependListener: [Function: socketListenerWrap],
      setEncoding: [Function: socketSetEncoding],
      _paused: false,
      _httpMessage: [Circular *1],
      _peername: [Object],
      [Symbol(async_id_symbol)]: 4470,
      [Symbol(kHandle)]: [TCP],
      [Symbol(lastWriteQueueSize)]: 0,
      [Symbol(timeout)]: null,
      [Symbol(kBuffer)]: null,
      [Symbol(kBufferCb)]: null,
      [Symbol(kBufferGen)]: null,
      [Symbol(shapeMode)]: true,
      [Symbol(kCapture)]: false,
      [Symbol(kSetNoDelay)]: true,
      [Symbol(kSetKeepAlive)]: false,
      [Symbol(kSetKeepAliveInitialDelay)]: 0,
      [Symbol(kBytesRead)]: 0,
      [Symbol(kBytesWritten)]: 0
    },
    _header: null,
    _keepAliveTimeout: 5000,
    _onPendingData: [Function: bound updateOutgoingData],
    req: IncomingMessage {
      _events: [Object],
      _readableState: [ReadableState],
      _maxListeners: undefined,
      socket: [Socket],
      httpVersionMajor: 1,
      httpVersionMinor: 1,
      httpVersion: '1.1',
      complete: true,
      rawHeaders: [Array],
      rawTrailers: [],
      joinDuplicateHeaders: null,
      aborted: false,
      upgrade: false,
      url: '/',
      method: 'POST',
      statusCode: null,
      statusMessage: null,
      client: [Socket],
      _consuming: true,
      _dumped: false,
      res: [Circular *1],
      next: [Function: next],
      baseUrl: '/graphql',
      originalUrl: '/graphql',
      _parsedUrl: [Url],
      params: [Object: null prototype] {},
      _eventsCount: 4,
      [Symbol(shapeMode)]: true,
      [Symbol(kCapture)]: false,
      [Symbol(kHeaders)]: [Object],
      [Symbol(kHeadersCount)]: 34,
      [Symbol(kTrailers)]: null,
      [Symbol(kTrailersCount)]: 0
    },
    _sent100: false,
    _expect_continue: false,
    _maxRequestsPerSocket: 0,
    locals: [Object: null prototype] {},
    [Symbol(shapeMode)]: false,
    [Symbol(kCapture)]: false,
    [Symbol(kBytesWritten)]: 0,
    [Symbol(kNeedDrain)]: false,
    [Symbol(corked)]: 0,
    [Symbol(kOutHeaders)]: [Object: null prototype] { 'x-powered-by': [Array] },
    [Symbol(errored)]: null,
    [Symbol(kHighWaterMark)]: 16384,
    [Symbol(kRejectNonStandardBodyWrites)]: false,
    [Symbol(kUniqueHeaders)]: null
  },
  waitUntil: [Function: waitUntil],
  request: PonyfillRequest {
    bodyInit: IncomingMessage {
      _events: [Object],
      _readableState: [ReadableState],
      _maxListeners: undefined,
      socket: [Socket],
      httpVersionMajor: 1,
      httpVersionMinor: 1,
      httpVersion: '1.1',
      complete: true,
      rawHeaders: [Array],
      rawTrailers: [],
      joinDuplicateHeaders: null,
      aborted: false,
      upgrade: false,
      url: '/',
      method: 'POST',
      statusCode: null,
      statusMessage: null,
      client: [Socket],
      _consuming: true,
      _dumped: false,
      res: [ServerResponse],
      next: [Function: next],
      baseUrl: '/graphql',
      originalUrl: '/graphql',
      _parsedUrl: [Url],
      params: [Object: null prototype] {},
      _eventsCount: 4,
      [Symbol(shapeMode)]: true,
      [Symbol(kCapture)]: false,
      [Symbol(kHeaders)]: [Object],
      [Symbol(kHeadersCount)]: 34,
      [Symbol(kTrailers)]: null,
      [Symbol(kTrailersCount)]: 0
    },
    options: {
      method: 'POST',
      headers: [Object],
      signal: [AbortSignal],
      body: [IncomingMessage],
      duplex: 'half'
    },
    bodyUsed: false,
    contentType: 'application/json',
    contentLength: 207,
    signal: AbortSignal { aborted: false },
    bodyType: 'Readable',
    _bodyFactory: [Function: bodyFactory],
    _generatedBody: PonyfillReadableStream {
      readable: [PassThrough],
      locked: false,
      [Symbol(Symbol.toStringTag)]: 'ReadableStream'
    },
    _buffer: <Buffer 7b 22 71 75 65 72 79 22 3a 22 6d 75 74 61 74 69 6f 6e 20 75 70 64 61 74 65 55 73 65 72 28 24 69 64 3a 49 44 21 24 65 6d 61 69 6c 3a 53 74 72 69 6e 67 ... 157 more bytes>,
    _chunks: [
      <Buffer 7b 22 71 75 65 72 79 22 3a 22 6d 75 74 61 74 69 6f 6e 20 75 70 64 61 74 65 55 73 65 72 28 24 69 64 3a 49 44 21 24 65 6d 61 69 6c 3a 53 74 72 69 6e 67 ... 157 more bytes>
    ],
    _blob: null,
    _formData: null,
    _json: {
      query: 'mutation updateUser($id:ID!$email:String!){updateUser(email:$email id:$id){id email}}',
      variables: [Object],
      operationName: 'updateUser'
    },
    _text: '{"query":"mutation updateUser($id:ID!$email:String!){updateUser(email:$email id:$id){id email}}","variables":{"id":"96e2dac1-4882-4cf9-9771-e3718b2a7513","email":"manish@m.com"},"operationName":"updateUser"}',
    headersSerializer: undefined,
    cache: 'default',
    credentials: 'same-origin',
    destination: 'document',
    headers: Headers {
      host: 'localhost:4000',
      connection: 'keep-alive',
      'content-length': '207',
      'sec-ch-ua-platform': '"Windows"',
      authorization: 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijk2ZTJkYWMxLTQ4ODItNGNmOS05NzcxLWUzNzE4YjJhNzUxMyIsImVtYWlsIjoibWFuaXNoQG0uY29tIiwiaWF0IjoxNzQ3NzEyODg0LCJleHAiOjE3NDc3MTY0ODR9.yNW9dUPJpKp42L4RRPVzxCgKAVUJsN96_gDyDZy3j_E',
      'user-agent': [
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML',
        'like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0'
      ],
      accept: [
        'application/graphql-response+json',
        'application/json',
        'multipart/mixed'
      ],
      'sec-ch-ua': [
        '"Chromium";v="136"',
        '"Microsoft Edge";v="136"',
        '"Not.A/Brand";v="99"'
      ],
      'content-type': 'application/json',
      'sec-ch-ua-mobile': '?0',
      origin: 'http://localhost:4000',
      'sec-fetch-site': 'same-origin',
      'sec-fetch-mode': 'cors',
      'sec-fetch-dest': 'empty',
      referer: 'http://localhost:4000/graphql?query=mutation+updateUser%28%24id%3AID%21%2C%24email%3A+String%21%29+%7B%0A++updateUser%28email%3A+%24email%2Cid%3A%24id%29+%7B%0A+++%0A+++id+%0A++++email%0A++%7D%0A%7D%0A',
      'accept-encoding': [ 'gzip', 'deflate', 'br', 'zstd' ],
      'accept-language': [ 'en-US', 'en;q=0.9' ]
    },
    integrity: '',
    keepalive: false,
    method: 'POST',
    mode: 'cors',
    priority: 'auto',
    redirect: 'follow',
    referrer: 'about:client',
    referrerPolicy: 'no-referrer',
    _url: 'http://localhost:4000/graphql',
    _parsedUrl: URL {
      href: 'http://localhost:4000/graphql',
      origin: 'http://localhost:4000',
      protocol: 'http:',
      username: '',
      password: '',
      host: 'localhost:4000',
      hostname: 'localhost',
      port: '4000',
      pathname: '/graphql',
      search: '',
      searchParams: URLSearchParams {},
      hash: ''
    },
    duplex: 'half',
    agent: undefined,
    [Symbol(Symbol.toStringTag)]: 'Request'
  },
  params: {
    query: 'mutation updateUser($id:ID!$email:String!){updateUser(email:$email id:$id){id email}}',
    variables: {
      id: '96e2dac1-4882-4cf9-9771-e3718b2a7513',
      email: 'manish@m.com'
    },
    operationName: 'updateUser'
  }
}
ERR TypeError: authHeader.replace is not a function
    at authenticate (C:\Users\manis\Desktop\all backend projects\dating_app_API\middleware\middleware.js:21:28)
    at Object.updateUser (C:\Users\manis\Desktop\all backend projects\dating_app_API\graphql_schema\user_schema.js:137:35)
    at executeField (C:\Users\manis\Desktop\all backend projects\dating_app_API\node_modules\@graphql-tools\executor\cjs\execution\execute.js:364:24)
    at results.<computed> (C:\Users\manis\Desktop\all backend projects\dating_app_API\node_modules\@graphql-tools\executor\cjs\execution\execute.js:289:64)
    at Promise.then (C:\Users\manis\Desktop\all backend projects\dating_app_API\node_modules\@whatwg-node\promise-helpers\cjs\index.js:48:40)
    at handleMaybePromise (C:\Users\manis\Desktop\all backend projects\dating_app_API\node_modules\@whatwg-node\promise-helpers\cjs\index.js:24:33)
    at C:\Users\manis\Desktop\all backend projects\dating_app_API\node_modules\@graphql-tools\executor\cjs\execution\execute.js:289:57
    at C:\Users\manis\Desktop\all backend projects\dating_app_API\node_modules\@graphql-tools\utils\cjs\jsutils.js:19:96
    at Promise.then (C:\Users\manis\Desktop\all backend projects\dating_app_API\node_modules\@whatwg-node\promise-helpers\cjs\index.js:48:40)
    at handleMaybePromise (C:\Users\manis\Desktop\all backend projects\dating_app_API\node_modules\@whatwg-node\promise-helpers\cjs\index.js:24:52) {
  path: [ 'updateUser' ],
  locations: [ { line: 1, column: 44 } ],
  extensions: [Object: null prototype] {}
}




