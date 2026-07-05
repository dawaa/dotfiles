---
name: obsidian-zettelkasten
description: "Create or edit notes in the user's personal Obsidian Zettelkasten vault at ~/.syncthing/obsidian/Personal/. Use whenever the user asks to write an atomic note, rough note, capture an idea/resource into their vault, add or fix tags, or otherwise work with their Obsidian notes. Handles the note template (timestamp / Tags wikilinks / References / divider), folder layout, and the 3_Tags/ placeholder convention. Trigger phrases: atomic note, zettelkasten, add to my vault, capture this note, Obsidian note, new note, tag note."
---

# Obsidian Zettelkasten Skill

Helps maintain the user's personal Obsidian vault. Match the existing conventions exactly — do not invent a different style.

## Vault location

Root: `/Users/jandro/.syncthing/obsidian/Personal/` (Syncthing-synced).

Numbered PARA/Zettelkasten folders observed:
- `1_Rough_Notes/` — unprocessed / fleeting notes
- `3_Tags/` — one file per tag (see below)
- `6_Atomic_Notes/` — permanent atomic notes (one idea per note)
- `7_Resources/`, plus topic trees like `Languages/Chinese/`

When unsure which folder a note belongs in, ask, or default to `6_Atomic_Notes/` for a developed idea and `1_Rough_Notes/` for a quick capture.

## Atomic note template

Every note follows this exact structure (note the blank lines and the trailing divider):

```
YYYY-MM-DD HH:MM

Tags: [[tag1]] [[tag2]]

# Title

<body — links to other notes/tags use [[wikilinks]]>

# References

[[related note]]
<url>


------------------------
```

- Get the timestamp with `date "+%Y-%m-%d %H:%M"` — do not guess it.
- Title in the `# Title` heading should match the filename (filenames use spaces, e.g. `Sync Obsidian flashcards to Anki.md`).
- Link liberally between notes with `[[Note Title]]` and to tags with `[[tag]]`.
- Keep each atomic note to a single idea; split into multiple cross-linked notes rather than one big note.

## Tags (3_Tags/ convention)

- Tags are **empty placeholder `.md` files** in `3_Tags/`, named after the tag (lowercase, spaces allowed): `chinese.md`, `study.md`, `reverse proxy.md`, etc.
- A `[[tag]]` wikilink in a note resolves to its file in `3_Tags/`.
- **Whenever you reference a `[[tag]]` that doesn't yet have a file in `3_Tags/`, create an empty stub** `3_Tags/<tag>.md` so the link isn't broken. Check the directory first to avoid duplicating an existing tag.

## Workflow

1. Confirm/choose the target folder.
2. Run `date "+%Y-%m-%d %H:%M"` for the header.
3. Write the note(s) in the template above.
4. For every `[[tag]]` used, `ls 3_Tags/` and create any missing empty stubs.
5. Tell the user the file paths created and which tag stubs were new.
