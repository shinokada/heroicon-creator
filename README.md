# SIC: Svelte SVG Icon Creator

This script creates a Svelte-heroicons and simpl-icons.

## Requirements

- Bash >= 5
- GNU sed

## Installation

Using [Awesome package manager](https://github.com/shinokada/awesome).

```sh
awesome install shinokada/svelte-svgicon-creator
```

Create a dir and run:

```sh
mkdir ~/Downloads/heroicons
cd ~/Downloads/heroicons
sic hero
```

All the icons are under `main` dir.

Move it to `svelte-heroicons` dir.

Create a package and publish.

```sh
cd /path/to/svelte-heroicons
// update the version in the package.json
npm run package
cd package
npm publish
```

## two command (Untested)

`sic two` command will create `optimize/outline` and `optimize/solid`
directories and their `index.js` in the dir.