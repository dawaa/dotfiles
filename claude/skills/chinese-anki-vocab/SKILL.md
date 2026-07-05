---
name: chinese-anki-vocab
description: "Turn the user's Taiwan Mandarin class vocab into Obsidian_to_Anki flashcard files. Use whenever the user pastes Chinese words/lessons and wants Anki cards, glossaries, or flashcards made, or asks about their Chinese vocab decks / syncing them to Anki. Handles the #flashcard format, Zhuyin-only Taiwan-standard conventions, filling in missing readings/radicals/example sentences, and deck/file naming. Trigger phrases: Chinese vocab, make flashcards, Anki cards, new lesson words, add these words, glossary, Zhuyin cards, Mandarin vocab."
---

# Chinese Anki Vocab Skill

The user takes remote Taiwan Mandarin classes and builds vocab glossaries for the **Obsidian_to_Anki** plugin. Generate card files that match their existing decks exactly.

## Location & files

- Cards live in `/Users/jandro/.syncthing/obsidian/Personal/Languages/Chinese/06_SRS_Cards/`.
- File naming:
  - HSK lessons: `HSK_1_Lesson_N_Vocab_M.md`
  - Class "side vocab" (e.g. teacher Harry on Amazing Talker): `AmazingTalker_Harry_Side_Vocab_LN.md` with deck `Amazing Talker Harry Side Vocab LN`.
- New side/non-lesson words go in a separate non-HSK-named file; ask which lesson/deck if unclear.

## Conventions (confirmed)

- **Traditional characters, Taiwan standard.** Use Taiwan readings and TOCFL/Taiwan usage, NOT mainland HSK. Write `臺灣` not `台湾`. The user respects Taiwan, not the PRC standard.
- **Zhuyin only — never add a Pinyin line.** (Even if the user pastes Pinyin in their source, omit it from the cards.)
- **Never add `<!--ID: ...-->` lines.** The Obsidian_to_Anki plugin writes those on first sync; new cards must ship without them. Don't edit or remove existing ID lines either.

## Card format

```
TARGET DECK: <deck name>

漢字 #flashcard
- Zhuyin: ㄗㄨㄛˋ
- English: to take (transportation)
- Radical: 土 (ㄊㄨˇ earth)
- Example sentence: 我每天坐公車去學校。
```

- `Radical:` line **only when a radical is worth noting**; format `部 (ㄅㄨˋ meaning)`. For variant/component forms use `攴 -> 攵 (ㄆㄨ tap)` or inline `人(亻) (ㄖㄣˊ person)`.
- Neutral tone written with `˙` (e.g. `ㄉㄜ˙`), matching their files.
- Separate cards with blank lines.

## Workflow when the user pastes words

1. Confirm the deck/file (or infer from context, e.g. next lesson number).
2. For each word, keep the user's Zhuyin/English if given; **fill in any missing Zhuyin, radical, and a natural Traditional/Taiwan example sentence yourself.**
3. If the user includes their own `Ex:` sentences, slot each onto the relevant card(s) it demonstrates (often a sentence covers several words in the batch).
4. Treat any sub-words the user gives full glosses for as their own cards (don't bury them as notes).
5. Write the file with no ID lines.
6. **Lint it** before telling the user it's ready — a quick Python check that the `TARGET DECK:` line exists, every `#flashcard` has `- Zhuyin:` and `- English:`, and there are 0 Pinyin lines and 0 ID lines.

## Syncing (the user does this, not you)

You **cannot** trigger the sync — it's a GUI action inside Obsidian. Tell the user:
1. Open the Anki desktop app (AnkiConnect must be running in the background).
2. In Obsidian: `Cmd+P` → **"Obsidian_to_Anki: Scan Vault"**.
3. On phone: tap **Synchronize** in AnkiDroid/AnkiMobile.

Setup details for Anki/AnkiConnect are documented in the user's vault notes `Sync Obsidian flashcards to Anki` and `AnkiConnect add-on config`.
