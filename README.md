# Grocerly

This is a sample application written for YourGrocer

## Installation

Clone this repo, then ```chmod +x bin/grocerly.rb```

## Usage

```$ bin/./grocerly -i <path-to-json-file> -o <path-to-output-dir>```

Afterwards, please cd into the output dir and launch a simple http server to handle the relative links.
I use ```python -m SimpleHTTPServer 8000``` just because it's fast and doesn't need config.

## Justifications

### Ruby's CGI vs a template engine.

In a real situation I'd be using a templating engine such as erb, slim or haml. This was hand rolled to reduce gem dependencies. It was interesting, given more time there are plenty of ways to improve it.
But actually it's very messy and full of complexity that a declarative syntax may not have.

### Why so much 'stuff'
Value objects: Sticking with primitives has always decreased the 'understandability' of the of code for our team.

Decorators: The pagination is a pretty general and useful tool. It made sense to build it as an isolated decorator.

Multiple specialised strategies: Thes html strategies fit into a broader context, the technique has been quite useful to me in the past. It made sense to use them here, without any real significant cost I had a bunch of objects with useful helpers, a consistent api and general enough that they could be substituted for a lambda. Made testing much easier too.

### Why the single letter variables?

I think that ```_retailers.map { |r| (_strip_unsafe(r) }``` is as immediately understandable as ```_retailers.map { |retailer| _strip_unsafe(retailer) }```.

### Why the godlike Main object?
This was not on purpose, I wanted to finish up. The duplicated code and lack of a clear, concise duty or responsibility highlight this problem. _This is the first thing I'd refactor_