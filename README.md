# mono

[![Build Status](https://travis-ci.org/meatwallace/js-mono.svg?branch=master)](https://travis-ci.org/meatwallace/js-mono)
[![Test Coverage](https://codeclimate.com/github/meatwallace/js-mono/badges/coverage.svg)](https://codeclimate.com/github/meatwallace/js-mono/coverage)
[![Code Climate](https://codeclimate.com/github/meatwallace/js-mono/badges/gpa.svg)](https://codeclimate.com/github/meatwallace/js-mono)

An organisation-level JavaScript monorepo configuration, demonstrating cross-project code sharing, dependency management, and tooling configuration.

## Introduction
Whilst we have [excellent monorepo tooling](https://github.com/lerna/lerna) for singlular JavaScript projects with multiple NPM modules, I have not come across good examples of an organisation-level monorepo configuration. Besides the many benefits of developing within a monorepo, this organisation-level pattern truely excels in a scenario that calls for significant code reusage across multiple projects that require entirely different build pipelines.

The scaffolding for the boilerplate is quite minimal, and the code is documented. The implementation is opinionated by requirement, but for the most part should be quite simple to change.

## Usage
The configuration has 3 key features:

- Common code sharing (without the need for publishing or versioning)
- Unified dependency management
- Intelligent change detection & project-specific build/deployment configuration

### Common code sharing
We have a dedicated folder for all cross-project code called `common`. By using the [babel-root-import](https://github.com/michaelzoidl/babel-root-import) plugin, we can refer to our common code by prefixing our import paths with `~`.

### Dependency management
By including projects in subfolders (ex. `/demo`), we can include our dependencies in the root `package.json` file, and resolve them in our projects using a filepath based dependency mapping. A working example of this can be seen in our demo project, using `"mono": "file:../"` to map to the root package, and successfully load in our `lodash` dependency.

### Change detection
Using Travis CI's commit range data, we are able to derive which projects have been changed and require rebuilding based on `git diff`'s output. Our Travis build script currently lookings for an npm `build` script in each changed project, and if exists, calls it. This can be used to do just about anything; each project can have an entirely different build/deployment setup.

### Need to knows
- Making changes to code in the `common` folder will trigger a build in all projects
- As an alternative to `babel-root-import`, Webpack's aliases could also we be used to resolve our common code
- `import/no-extraneous-dependencies` must be disabled in ESLint as root-level dependencies will not resolve
- Only root-level `dependencies` will be loaded into our projects, not `devDependencies

## Contributing
Please submit a pull request!

This repository uses [commitizen](https://github.com/commitizen/cz-cli); please be sure to leave useful commit messages.