# Gitlab-Pharo-API

This is a Pharo client for the [Gitlab REST API](https://docs.gitlab.com/ee/api/rest/)

## Installation 

```st
Metacello new
  githubUser: 'Evref-BL' project: 'Gitlab-Pharo-API' commitish: 'develop' path: 'src';
  baseline: 'GitlabAPI';
  onConflict: [ :ex | ex useIncoming ];
  load
```