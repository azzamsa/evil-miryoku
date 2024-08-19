# Evil Miryoku

This package provide a keybindings for [evil-mode][evil-mode] with [Miryoku][miryoku] layout.

## Key bindings

| Miryoku            | Qwerty             | Action                   | States |
|--------------------|--------------------|--------------------------|--------|
| `n`, `e`, `i`, `o` | `h`, `j`, `k`, `l` | navigate                 | `mnvo` |
| `k`, `K`           | `n`, `N`           | search next/previous     | `mnvo` |
| `u`, `U`           | `i`, `I`           | insert                   | `_nv_` |
| `l`                | `u`                | undo                     | `_n__` |
| `N`                | `J`                | join lines               | `_nv_` |
| `E`                | `K`                | lookup                   | `mnv_` |
| `I`                | `L`                | jump to bottom of window | `mnvo` |
| `l`, `L`           | `u`, `U`           | downcase/upcase          | `__v_` |
| `u`                | `i`                | inner text object keymap | `___o` |
| `f`, `F`           | `e`, `E`           | jump to end of word      | `mnvo` |
| `t`, `T`           | `f`, `F`           | jump to character        | `mnvo` |
| `j`, `J`           | `t`, `T`           | jump until character     | `mnvo` |
| `j`, `J`           | `e`, `E`           | jump to end of word      | `mnvo` |


## Installation


``` elisp
(straight-use-package
 '(evil-miryoku :type git :host github :repo "azzamsa/evil-miryoku"))
```

## Usage

To enable globally, use:

```
M-x global-evil-miryoku-mode RET
```

To enable permanently, call `(global-evil-miryoku-mode)` from
your `init.el`. With `use-package` this looks like this:

``` elisp
(use-package evil-miryoku
  :config
  (global-evil-miryoku-mode))
```

When enabled, a lighter showing `neio` will appear in your mode line. If
you don't like it, use `rich-minority` or `diminish` to hide it.

## Configuration

Use the customize interface to get more information about the settings:

    M-x customize-group RET evil-miryoku RET

However, since the settings *must* be set before loading the package
(since they influence how the keymap is constructed), the most reliable
way is to put `(setq …)` in your `init.el` file, before using
`(require …)` or invoking any of the autoloaded functions like
`(global-evil-miryoku-mode)`. With `use-package`, use `:init`
like this:

``` elisp
(use-package evil-miryoku
  :init
  (setq evil-miryoku-... ...)
  :config
  (global-evil-miryoku-mode))
```

### evil-snipe

To use [evil-snipe](https://github.com/hlissner/evil-snipe) for the
‘jump to character’ and ‘jump until character’ commands, use:

``` elisp
(setq evil-miryoku-char-jump-commands 'evil-snipe)
```

Note that this package will load `evil-snipe`, so if you have any
configuration that should be set before `evil-snipe` is loaded, such as
`evil-snipe-auto-disable-substitute`, make sure to configure
`evil-snipe` before this package is loaded. With `use-package` it looks
like this:

``` elisp
(use-package evil-miryoku
  :after evil evil-snipe
  :init
  (setq evil-miryoku-char-jump-commands 'evil-snipe)
  :config
  (global-evil-miryoku-mode))
```

### visual-line-mode

Make movement commands respect `visual-line-mode` with:

``` elisp
(setq evil-respect-visual-line-mode t)
```

## Credits

This package is based on awesome [evil-colemak-basics][evil-colemak-basics] by Wouter Bolsterlee.

[evil-mode]: https://github.com/emacs-evil/evil
[miryoku]: https://github.com/manna-harbour/miryoku
[evil-colemak-basics]: https://github.com/wbolster/emacs-evil-colemak-basics
