# Gitlab-Pharo-API

[![Continuous](https://github.com/Evref-BL/Gitlab-Pharo-API/actions/workflows/continuous.yml/badge.svg)](https://github.com/Evref-BL/Gitlab-Pharo-API/actions/workflows/continuous.yml)
[![Coverage Status](https://coveralls.io/repos/github/Evref-BL/Gitlab-Pharo-API/badge.svg?branch=ci-add-coverage)](https://coveralls.io/github/Evref-BL/Gitlab-Pharo-API?branch=ci-add-coverage)

This is a Pharo client for the [Gitlab REST API](https://docs.gitlab.com/ee/api/rest/)

## Installation 

```st
Metacello new
  githubUser: 'Evref-BL' project: 'Gitlab-Pharo-API' commitish: 'develop' path: 'src';
  baseline: 'GitlabAPI';
  onConflict: [ :ex | ex useIncoming ];
  load
```