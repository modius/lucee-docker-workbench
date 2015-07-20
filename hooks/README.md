## hooks for tutum/builder

A docker image that builds, tests and pushes docker images from code repositories.
https://github.com/tutumcloud/builder#hooks

_Note, the hooks folder is totally optional and only required for builds using the `tutum/builder`; for example, if you are on the tutm private registry for builds._

Docker image build needs to pull the contents of the `./code` folder via `git submodule update`.