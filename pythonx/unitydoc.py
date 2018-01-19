# Python code for processing the type index file.

import vim

def load_cache():
    type_index_file = vim.eval("a:type_index_file")

    cache = []
    with open(type_index_file) as f:
        for t in f.readlines():
            t = t.strip()
            if len(t) == 0:
                continue
            components = t.split('\t')
            name, page = components[0], components[1]
            entry = vim.Dictionary(
                word =   name,
                kind =   'common',
                source = 'unitydoc',
                action__page = page,
            )
            cache.append(entry)

    p = vim.Function('unite#sources#unitydoc#set_cache', args=[cache])
    p()
