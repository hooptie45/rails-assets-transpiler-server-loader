# rails-assets-transpiler-server-loader

Simple loader to transpile sprockets erb files

## Requirements

- Ruby
- [haml-transpiler-server](https://github.com/Fire-Dragon-DoL/haml-transpiler-server)

## Installation

    gem install rails-assets-transpiler-server-loader

## Usage

Use it as a simple loader in your webpack configuration:

```js
{
  test: /\.erb$/,
  loader: "rails-assets-transpiler-server-loader",
  exclude: [
    /node_modules/
  ]
}
```
