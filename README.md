# Ruby CI image

Ruby image for CI/CD pipeline. The image has JQ, Node JS, Chrome and ChromeDriver pre installed.
It runs as a low level user `app` to be able to start the Chrome.

### How the build image works
The `build_push.sh` takes the Ruby version as an argurment.

E.g. for Ruby 2.7.6
```
./build_push.sh 2.7.6
```

E.g. for Ruby 3.1.2
```
./build_push.sh 3.1.2
```

### Push new ruby images to the registry
Add a new section to the `.gitlab-ci.yml` with the new Ruby version.
Commit and push the code to the registry. Once merged into the `main` branch the pipeline will created all Ruby images
