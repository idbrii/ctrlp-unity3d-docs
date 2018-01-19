vim-unityengine-docs
====================
Search Unity game engine docs using ctrlp or unite.

Use your favourite incremental search to find documentation pages. Opens the
pages in a browser.

Usage
-----

* Use `:CtrlPUnity3DDocs` or `:Unite unitydoc` to launch the search.
* Hit `<CR>` to view the selected item in browser

Requirements
------------

* [CtrlP](https://github.com/kien/ctrlp.vim) or [unite](https://github.com/Shougo/unite.vim) for the search mechanism
* [gogo](https://github.com/idbrii/vim-gogo) for launching the browser

Todo
----

* Perform check if required plugins are available
* Integrate python tool with Vim (to re-download the index for a new version of Unity).

Rebuilding index
----------------

Use the `tools/unity3d-docs-download.py` python script to re-download the index.
It's written against Python 2.7 in order to integrate it into vim at some point.

Caveats
-------

In order not to rely on third party libraries, the information is pulled from 
the Unity docs website using *HTMLParser*. If the structure of the site was 
to change, the tool will need to be adapted.
