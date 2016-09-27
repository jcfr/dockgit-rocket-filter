dockgit-rocket-filter
======================

Dockerized version of `GitRocketFilter <https://github.com/xoofx/GitRocketFilter>`_: Rewrite git branches in a powerful way.

.. |dockgit-rocket-filter| image:: https://badge.imagelayers.io/jcfr/dockgit-rocket-filter:latest.svg
  :target: https://imagelayers.io/?images=jcfr/dockgit-rocket-filter:latest

jcfr/dockgit-rocket-filter
  |dockgit-rocket-filter| Dockerized version of GitRocketFilter.


Features
--------

The purpose of ``git-rocket-filter`` is similar to the command `git-filter-branch <http://git-scm.com/docs/git-filter-branch`_
while providing the following unique features:

* Fast rewriting of commits and trees (by an order of `x10` to `x100`).
* Built-in support for both **white-listing** with `--keep` (keeps files or directories) and **black-listing** with `--remove` options.
* Use of `.gitignore` like pattern for tree-filtering
* Fast and easy C# Scripting for both commit filtering and tree filtering
* Support for scripting in tree-filtering per file/directory pattern
* Automatically prune empty/unchanged commit, including merge commits


Installation
------------

This image does not need to be run manually. Instead, there is a helper script
to execute it.

To install the helper script, copy the script `git-rocket-filter` in your `PATH`::

  curl https://raw.githubusercontent.com/jcfr/dockgit-rocket-filter/master/git-rocket-filter.sh \
    -o ~/bin/git-rocket-filter && \
  chmod +x ~/bin/git-rocket-filter


Maintainance
------------

To rebuild the image::

  git clone git://github.com/jcfr/dockgit-rocket-filter
  make build


To publish the image::

  docker login -u <user> -p <password>
  make push


---

Credits go to `sdt/docker-raspberry-pi-cross-compiler <https://github.com/sdt/docker-raspberry-pi-cross-compiler>`_, who invented the base of the dockerized script.
