# terraform-autodocs

Automatically add terraform-docs to a terraform project's README

## Overview

Makes use of `pandoc` and `terraform-docs` and some bash to automate the merging of a terraform project's README and `terraform-docs` output.

## How to use

Create a `_docs` folder in the top level of your terraform module. Then write your `README.md` like you normally would. When you are ready to generate your docs just run `autodocs.sh` from anywhere in your project.

**Note:** the results of `terraform-docs` will be appended to the _end_ of the generated `README.md`

### Install dependencies

The script will auto-fail if `pandoc` or `terraform-docs` are not installed.

If you are using a mac both utilities can be installed with `brew`. Alternatively you can follow each tool's installation guide:

- [pandoc](https://www.pandoc.org/installing.html)
- [terraform-docs](https://github.com/segmentio/terraform-docs#installation)

### Run autodocs.sh

``` sh
chmod +x autodocs.sh
./autodocs.sh
```

### Expected output

`autodocs` will search for all directories within your project that contain files with the `.tf` extension, and then for any directory within those results that contain a `_docs` folder. After confirming if a `README.md` file exists, a `TF_MODULE.md` file will be generated using `terraform-docs` in the `_docs` directory. Then `pandoc` is called to merge the two files and outputs their result to `README.md` in the module's folder.

### Project structure pre-autodocs

``` sh
.
├── _docs
│   └── README.md
├── main.tf
└── variables.tf

```

### Project structure post-autodocs

``` sh
.
├── README.md
├── _docs
│   ├── README.md
│   └── TF_MODULE.md
├── main.tf
└── variables.tf

```