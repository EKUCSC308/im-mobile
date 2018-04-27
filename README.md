# Instant Messenger Mobile (iPhone)

## Installation

### Step 1: Set up the package manager

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

### Step 2: Install application dependencies
Cocoa is a package manager. In other words, it allows us to import third-party software into our application. Our app is already configured. You just have to install tell cocoa to install the third-party software onto your laptop.

Navigate to the `/src` directory inside of a clone of this repo. Then execute the following command:

```
pod install
```

## All set
Continue development as normal.
