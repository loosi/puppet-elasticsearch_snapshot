# elasticsearch_snapshot

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with elasticsearch_snapshot](#setup)
    * [What elasticsearch_snapshot affects](#what-elasticsearch_snapshot-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with elasticsearch_snapshot](#beginning-with-elasticsearch_snapshot)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Create and restore elastic search snapshots

## Module Description

Well what would it do.

## Setup

### What elasticsearch_snapshot affects

* created snaphots, data is stored somewhere.

### Setup Requirements

The module does not require anything. If you have a Elasticsearch cluster, you need
a shared storage solution, since all Elasticsearch nodes need able to write at the
same location.

### Beginning with elasticsearch_snapshot

git clone https://github.com/naturalis/puppet-elasticsearch_snapshot

## Usage

**Create a repository**

```
es_repo { 'mybackup':
  ensure   => present,
  type     => 'fs',
  settings => {
    'location' => '/data/backup'
  },
  ip       => '127.0.0.1',
  port     => '9200',
}
```

**Create a snapshot**

```
es_snapshot { 'snapshot':
  ensure        => present,
  snapshot_name => 'snapshot_name_with_date',
  repo          => 'mybackup',
  ip            => '127.0.0.1',
  port          => '9200',
}
```
The resource name is 'snapshot' but the name of the snapshot is different. You can for
example name the snapshot with a variable date. The resource name is the same, which is
nice for puppet.

**Restore a snapshot**

```
es_restore { 'restore_job':
  ensure        => present,
  snapshot_name => 'snapshot_name_with_date',
  store_state   => true,
  repo          => 'mybackup',
  ip            => '127.0.0.1',
  port          => '9200',
}
```

After a restore, a index .es_snapshot is created in elasticsearch with a document. This is importart
since the es_restore type than check if the restore is done. Set `store_state => false` to disable this.


## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You may also add any additional sections you feel are
necessary or important to include here. Please use the `## ` header.
