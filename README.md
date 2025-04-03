# Gitlab-Pharo-API

[![Continuous](https://github.com/Evref-BL/Gitlab-Pharo-API/actions/workflows/continuous.yml/badge.svg)](https://github.com/Evref-BL/Gitlab-Pharo-API/actions/workflows/continuous.yml)
[![Coverage Status](https://coveralls.io/repos/github/Evref-BL/Gitlab-Pharo-API/badge.svg?branch=ci-add-coverage)](https://coveralls.io/github/Evref-BL/Gitlab-Pharo-API?branch=develop)

This is a Pharo client for the [Gitlab REST API](https://docs.gitlab.com/ee/api/rest/)

## Usage

### Installation

#### From playground

```st
Metacello new
  githubUser: 'Evref-BL' project: 'Gitlab-Pharo-API' commitish: 'develop' path: 'src';
  baseline: 'GitlabAPI';
  onConflict: [ :ex | ex useIncoming ];
  load
```

#### Baseline dependency

```st
spec baseline: 'GitlabAPI' with: [
	spec repository: 'github://Evref-BL/Gitlab-Pharo-API:develop' ];
```

### Client

To start using the API, you need to create a client instance with your GitLab host URL and a private token for authentication. Here’s an example:

```st
gitlabApi := GitlabApi new
	privateToken: '<your token>';
	hostUrl: 'https://<your gitlab domain>.com/api/v4';
	yourself.
```

Replace `<your token>` with your actual GitLab private token and replace `<your gitlab domain>` with the appropriate domain.

### Ressources

The API provides different resource classes to interact with various GitLab entities. These resources include:

- branches
- commits
- discussions
- groups
- jobs
- mergeRequests
- notes
- pipelines
- projects
- repositories
- users

Each resource provides methods for interacting with the corresponding GitLab resource. You can access them like this:

```st
gitlabApi projects <method>
```

### Example

Here are a few examples of how to interact with the API:

#### Fetch All Projects

This example retrieves all projects from GitLab:

```st
| projects |
projects := gitlabApi projects all
```

#### Fetch All Projects Sorted in Ascending Order

This example demonstrates how to fetch all projects sorted in ascending order, using parameters:

```st
| projects params |
params := {
  #sort -> 'asc'
} asDictionary.

projects := gitlabApi projects allWithParams: params.
```
