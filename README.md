# Ruby CI image

Ruby image for CI/CD pipeline. The image has JQ, Node JS, Chrome and ChromeDriver pre installed.
It runs as a low level user `app` to be able to start the Chrome.

### How the build image works
The `build_push.sh` takes the Ruby version as an argument and builds/pushes the image with `docker buildx`. It defaults to multi-arch (`linux/amd64,linux/arm64`) so a push from any machine — including Apple Silicon Macs — always contains the linux/amd64 variant the CI runners need. After pushing it verifies the manifest actually lists linux/amd64 and fails otherwise.

E.g. for Ruby 3.4.10
```
./build_push.sh 3.4.10
```

Override the platforms if you ever need to (requires Docker Buildx with binfmt/QEMU for non-native arches):
```
PLATFORMS="linux/amd64" ./build_push.sh 3.4.10
```

### Push new ruby images to the registry
Add a new section to the `.gitlab-ci.yml` with the new Ruby version.
Commit and push the code to the registry. Once merged into the `main` branch the pipeline will create all Ruby images.


### CI

GitHub Actions
- Trigger: push to main, tags deploy-*, and manual dispatch.
- Output: pushes ghcr.io/adcombi/ruby-ci-image:<ruby_version>.
- Permissions: ensure the workflow has packages: write (set in the workflow). If the repo is under the same organization as the GHCR namespace (adcombi), GITHUB_TOKEN is sufficient.

GitLab CI
- Trigger: main branch and tags matching deploy-*.
- Runner: docker with docker:dind.
- Required variables in project/group settings:
  - CI_GITHUB_USER: GitHub username with access to push to ghcr.io/adcombi.
  - CI_GITHUB_TOKEN: GitHub token with write:packages scope (and read:packages).