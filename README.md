# Instant Messenger Mobile (iPhone)

## Installation

### Set up the package manager

> You shouldn't have to set up the package manager more than once per laptop.

Install swift package manager, `cocoa`.

```
gem install cocoapods --user-install
```

Then add the path to cocoa's installation to the system environment variables.

```
export PATH=/Users/student/.gem/ruby/2.3.0/bin:$PATH
```

Verify your installation. Close the terminal, reopen it, then run:

```
pod
```

The above command should output a list of acceptable commands. If you get a "command not found error", something isn't right.
