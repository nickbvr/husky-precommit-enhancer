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

## Demo:

Check out the demo to see the script in action

https://github.com/nickbvr/husky-precommit-enhancer/assets/63242837/792a0886-ba11-4479-b349-026341e8462e

If an error occurs, it will be displayed as follows:

<img width="686" alt="Screenshot 2023-07-11 at 2 40 54 PM" src="https://github.com/nickbvr/husky-precommit-enhancer/assets/63242837/1c94fc60-f3d2-4118-a4a3-642436d0eb2f">

### If you found this useful, give it a star 😄
