;;; evil-miryoku.el --- Miryoku key bindings for evil-mode

;; Author: Azzam S.A <noreply@azzamsa.com>
;; Author: Wouter Bolsterlee <wouter@bolsterl.ee>
;; Version: 2.3.0
;; Package-Requires: ((emacs "24.3") (evil "1.2.12") (evil-snipe "2.0.3"))
;; Keywords: convenience emulations colemak evil miryoku
;; URL: https://github.com/azzamsa/evil-miryoku
;;
;; This file is not part of GNU Emacs.

;;; License:

;; Licensed under the same terms as Emacs.

;;; Commentary:

;; This package provides basic key rebindings for evil-mode with the
;; Miryoku keyboard layout. See the README for more information.
;;
;; To enable globally, use:
;;
;;   (global-evil-miryoku-mode)
;;
;; To enable for just a single buffer, use:
;;
;;   (evil-miryoku-mode)

;;; Code:

(require 'evil)
(require 'evil-snipe)

(defgroup evil-miryoku nil
  "Basic key rebindings for evil-mode with the Miryoku keyboard layout."
  :prefix "evil-miryoku-"
  :group 'evil)

(defcustom evil-miryoku-char-jump-commands nil
  "The set of commands to use for jumping to characters.

           By default, the built-in evil commands evil-find-char (and
                                                                   variations) are used; when set to the symbol 'evil-snipe, this
           behaves like evil-snipe-override-mode, but adapted to the right
           keys.

           This setting is only used when the character jump commands are
           rotated; see evil-miryoku-rotate-t-f-j."
  :group 'evil-miryoku
  :type '(choice (const :tag "default" nil)
                 (const :tag "evil-snipe" evil-snipe)))

(defun evil-miryoku--make-keymap ()
  "Initialise the keymap based on the current configuration."
  (let ((keymap (make-sparse-keymap)))
    (evil-define-key '(motion normal visual) keymap
      ;;
      ;; Navigation
      ;;     ^
      ;;     i
      ;; < n   o >
      ;;     e
      ;;     v

      ;; qwerty: j
      ;; wbolster: n
      ;; miryoku: e
      "e" 'evil-next-line
      "ge" 'evil-next-visual-line

      ;; qwerty: k
      ;; wbolster: e
      ;; miryoku: i
      "i" 'evil-previous-line
      "I" 'evil-lookup
      "gi" 'evil-previous-visual-line

      ;; qwerty: l
      ;; wbolster: i
      ;; miryoku: o
      "o" 'evil-forward-char
      "O" 'evil-window-bottom
      "zo" 'evil-scroll-column-right
      "zO" 'evil-scroll-right

      ;; qwerty: h
      ;; wbolster: h (↕️)
      ;; miryoku: n
      "n" 'evil-backward-char

      ;; qwerty: t
      ;; wbolster: j
      ;; miryoku: (↕️)
      "j" 'evil-forward-word-end
      "J" 'evil-forward-WORD-end
      "gj" 'evil-backward-word-end
      "gJ" 'evil-backward-WORD-end

      ;; qwerty: n
      ;; wbolster: k
      ;; miryoku: (↕️)
      "k" (if (eq evil-search-module 'evil-search) 'evil-ex-search-next 'evil-search-next)
      "K" (if (eq evil-search-module 'evil-search) 'evil-ex-search-previous 'evil-search-previous)
      "gk" 'evil-next-match
      "gK" 'evil-previous-match)
    (evil-define-key '(normal visual) keymap
      "h" 'evil-set-marker

      "N" 'evil-join
      "gN" 'evil-join-whitespace

      "gl" 'evil-downcase
      "gL" 'evil-upcase)
    (evil-define-key 'normal keymap
      "l" 'evil-undo

      "u" 'evil-insert
      "U" 'evil-insert-line
      "gu" 'evil-insert-resume
      "gU" 'evil-insert-0-line

      "m" 'evil-open-below)
    (evil-define-key 'visual keymap
      "l" 'evil-downcase
      "L" 'evil-upcase

      "U" 'evil-insert)
    (evil-define-key '(visual operator) keymap
      "u" evil-inner-text-objects-map)
    (evil-define-key 'operator keymap
      "o" 'evil-forward-char)
    (cond
     ((eq evil-colemak-basics-char-jump-commands nil)
      (evil-define-key '(motion normal visual) keymap
        "t" 'evil-find-char
        "T" 'evil-find-char-backward
        "j" 'evil-find-char-to
        "J" 'evil-find-char-to-backward))
     ((eq evil-colemak-basics-char-jump-commands 'evil-snipe)
      ;; XXX https://github.com/hlissner/evil-snipe/issues/46
      (evil-snipe-def 1 inclusive "t" "T")
      (evil-snipe-def 1 exclusive "j" "J")
      (evil-define-key '(motion normal visual) keymap
        "t" 'evil-snipe-t
        "T" 'evil-snipe-T
        "j" 'evil-snipe-j
        "J" 'evil-snipe-J))
     (t (user-error "Invalid evil-colemak-basics-char-jump-commands configuration")))
    (when evil-respect-visual-line-mode
      (evil-define-key '(motion normal visual) keymap
        "e" 'evil-next-visual-line
        "ge" 'evil-next-line

        "i" 'evil-previous-visual-line
        "gi" 'evil-previous-line

        "0" 'evil-beginning-of-visual-line
        "g0" 'evil-beginning-of-line
        "$" 'evil-end-of-visual-line
        "g$" 'evil-end-of-line
        "V" 'evil-visual-screen-line))
    keymap))

(defvar evil-miryoku-keymap
  (evil-miryoku--make-keymap)
  "Keymap for evil-miryoku-mode.")

(defun evil-miryoku--refresh-keymap ()
  "Refresh the keymap using the current configuration."
  (setq evil-miryoku-keymap (evil-miryoku--make-keymap)))

;;;###autoload
(define-minor-mode evil-miryoku-mode
  "Minor mode with evil-mode enhancements for the Miryoku keyboard layout."
  :keymap evil-miryoku-keymap
  :lighter " meio")

;;;###autoload
(define-globalized-minor-mode global-evil-miryoku-mode
  evil-miryoku-mode
  (lambda () (evil-miryoku-mode t))
  "Global minor mode with evil-mode enhancements for the Miryoku keyboard layout.")

(provide 'evil-miryoku)

