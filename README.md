# Husky Pre-Commit Enhancer

A script that enhances commit checks for your repository, providing a visually pleasing and informative experience.

## Features

- Beautiful command line output with colored messages
- Running build checks before committing
- Running tests to ensure code integrity
- Code linting and formatting checks
- Easy setup and integration with Husky

## Customization

The script can be customized to suit your specific needs. You can modify the commands, add additional checks, or enhance the visual styling. Refer to the script files for more details.

## Usage

To use this script, make sure you have husky installed. You can install it using the following command:

`npx husky add .husky/pre-commit "yarn test"`

Then, replace the `yarn test` command in the `.husky/pre-commit` file with our script.

### If you found this useful, give it a star 😄
