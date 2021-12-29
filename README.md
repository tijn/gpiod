# gpiod

The sysfs interface (`/sys/class/gpio`) has been deprecated for a while so this library implements bindings for the chardev interface that replaces it.

You can read more about it [here](https://embeddedbits.org/new-linux-kernel-gpio-user-space-interface/).

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     gpiod:
       github: tijn/gpiod
   ```

2. Run `shards install`

## Usage

```crystal
require "gpiod"
```

TODO: Write usage instructions here

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/tijn/gpiod/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Tijn Schuurmans](https://github.com/tijn) - creator and maintainer
