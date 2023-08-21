## Adding a new page

Note: Before this step you need to install [mason cli](https://pub.dev/packages/mason_cli).
After installation execute `mason get` command to get `page` brick.

1. Generate page with mason generator as below. This generates view folder, view function, generated view class and view
   model.

```
 mason make page --name <page_name_snake_case>
```

2. Follow created content directives to add page to route
