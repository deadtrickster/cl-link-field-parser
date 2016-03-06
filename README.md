##  `Link` header field parser

See [RFC 5988](https://tools.ietf.org/html/rfc5988)

## Example

```lisp
(link-field:parse "<https://api.github.com/user/deadtrickster/repos?client_id=1&client_secret=2&page=2&per_page=100>; rel=\"next\", <https://api.github.com/user/deadtrickster/repos?client_id=1&client_secret=2&page=3&per_page=100>; rel=\"last\"")

({i
   "href" "https://api.github.com/user/deadtrickster/repos?client_id=1&client_secret=2&page=2&per_page=100"
   "rel" "next"
   }
 {i
   "href" "https://api.github.com/user/deadtrickster/repos?client_id=1&client_secret=2&page=3&per_page=100"
   "rel" "last"
   })
```

## License
MIT
